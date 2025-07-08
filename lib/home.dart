import 'package:estetify/descricao.dart';
import 'package:flutter/material.dart';
import 'package:estetify/carrinho_agenda.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _produtos = [];
  List<Map<String, dynamic>> _servicos = [];
  bool _carregando = true;

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CarrinhoAgendaScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      barrierColor: Colors.black.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filtrar por',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Estabelecimentos mais próximos de mim'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Estabelecimentos próximos a minha casa'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.design_services),
                title: const Text('Tipos de serviço'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: const Text('Tipos de produtos'),
                onTap: () {},
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fechar'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _abrirDescricao({required bool isProduto, required Map<String, dynamic> dados}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaDescricao(isProduto: isProduto, dados: dados),
      ),
    );
  }

  Widget _buildPostCard({
    required String profileUrl,
    required String name,
    required String distance,
    required String imageUrl,
    required String title,
    required String description,
    bool isProduto = true,
    String preco = '',
    String precoEntrega = '',
    String empresa = '',
    List<String> categorias = const [],
    List<Map<String, dynamic>> relacionados = const [],
    List<Map<String, dynamic>> feedbacks = const [],
    List<Map<String, dynamic>> variaveis = const [],
  }) {
    // Se houver variáveis, pega o menor preço
    String precoExibido = preco;
    if (variaveis.isNotEmpty) {
      final menor = variaveis.map((v) => v['preco'] as num).reduce((a, b) => a < b ? a : b);
      precoExibido = 'R\$ ${menor.toStringAsFixed(2)}';
    }
    return GestureDetector(
      onTap: () {
        _abrirDescricao(
          isProduto: isProduto,
          dados: {
            'categorias': categorias,
            'imagem': imageUrl,
            'nome': title,
            'preco': precoExibido,
            'precoEntrega': precoEntrega,
            'empresa': empresa.isNotEmpty ? empresa : name,
            'descricao': description,
            'relacionados': relacionados,
            'feedbacks': feedbacks,
            'variaveis': variaveis,
          },
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(profileUrl),
                    radius: 22,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          distance,
                          style: const TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.zero, bottom: Radius.circular(0)),
              child: Container(
                width: double.infinity,
                height: 180,
                color: Colors.grey[100],
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.network(
                    imageUrl,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 180,
                      height: 180,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, size: 60, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14),
                  ),
                  if (variaveis.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text('A partir de', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                    Text(precoExibido, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF7043))),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() => _carregando = true);
    try {
      final produtosResp = await http.get(Uri.parse('https://api-rest-estetify.onrender.com/api/itens'));
      final servicosResp = await http.get(Uri.parse('https://api-rest-estetify.onrender.com/api/service'));
      if (produtosResp.statusCode == 200 && servicosResp.statusCode == 200) {
        final List<dynamic> produtosJson = json.decode(produtosResp.body);
        final List<dynamic> servicosJson = json.decode(servicosResp.body);
        setState(() {
          _produtos = produtosJson.cast<Map<String, dynamic>>();
          _servicos = servicosJson.cast<Map<String, dynamic>>();
          _carregando = false;
        });
      } else {
        setState(() => _carregando = false);
      }
    } catch (e) {
      setState(() => _carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Paleta de cores do README.md
    const azul = Color(0xFF2c3e50);
    const laranja = Color(0xFFFF7043);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: laranja,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.map),
          tooltip: 'Ver no mapa',
          color: Colors.white,
          onPressed: () {},
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'encontre seu desejo',
              prefixIcon: Icon(Icons.search, color: azul),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_rounded),
            tooltip: 'Filtrar',
            color: Colors.white,
            onPressed: _showFilterModal,
          ),
        ],
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ..._servicos.map((servico) => _buildPostCard(
                      profileUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
                      name: utf8.decode((servico['name'] ?? '').toString().runes.toList()),
                      distance: '',
                      imageUrl: servico['image'] ?? '',
                      title: utf8.decode((servico['name'] ?? '').toString().runes.toList()),
                      description: 'Serviço disponível',
                      isProduto: false,
                      preco: 'R\$ ${servico['price']?.toStringAsFixed(2) ?? ''}',
                      empresa: '',
                      categorias: [],
                      relacionados: [],
                      feedbacks: [],
                      variaveis: [],
                    )),
                ..._produtos.map((produto) => _buildPostCard(
                      profileUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
                      name: utf8.decode((produto['name'] ?? '').toString().runes.toList()),
                      distance: '',
                      imageUrl: produto['image']?.toString().startsWith('http') == true
                          ? produto['image']
                          : 'https://via.placeholder.com/300x180.png?text=Produto',
                      title: utf8.decode((produto['name'] ?? '').toString().runes.toList()),
                      description: 'Produto disponível',
                      isProduto: true,
                      preco: 'R\$ ${produto['price']?.toStringAsFixed(2) ?? ''}',
                      empresa: produto['mark'] ?? '',
                      categorias: [],
                      relacionados: [],
                      feedbacks: [],
                      variaveis: [],
                    )),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: laranja,
        unselectedItemColor: azul,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
      ),
    );
  }
}
