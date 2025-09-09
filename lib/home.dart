// Arquivo: home.dart
import 'package:estetify/descricao.dart';
import 'package:estetify/perfil.dart';
import 'package:flutter/material.dart';
import 'package:estetify/carrinho_agenda.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

 void _onItemTapped(int index) {
  if (index == 1) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CarrinhoAgendaScreen()),
    );
  } else if (index == 3) {
    // Navegar para a tela de perfil
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PerfilPage()),
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
              child: Image.network(
                imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPostCard(
            profileUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
            name: 'Estética Bella',
            distance: '1,2 km de você',
            imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9',
            title: 'Corte e Escova',
            description: 'Transforme seu visual com nosso corte e escova profissional!',
            isProduto: false,
            preco: 'R\$ 80,00',
            empresa: 'Estética Bella',
            categorias: ['Cabelo', 'Escova'],
            relacionados: [
              {
                'imagem': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
                'nome': ' Pomada Modeladora',
              },
            ],
            feedbacks: [
              {
                'foto': 'https://randomuser.me/api/portraits/women/44.jpg',
                'usuario': 'Ana',
                'comentario': 'Ótimo atendimento!',
                'nota': 5,
              },
            ],
            variaveis: [
              {'nome': 'Simples', 'preco': 80.0},
              {'nome': 'Com hidratação', 'preco': 120.0},
            ],
          ),
          _buildPostCard(
            profileUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
            name: 'Salão do João',
            distance: '2,5 km de você',
            imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
            title: 'Barba e Cabelo',
            description: 'Pacote especial para barba e cabelo. Agende já!',
            isProduto: false,
            preco: 'R\$ 60,00',
            empresa: 'Salão do João',
            categorias: ['Barba', 'Cabelo'],
            relacionados: [],
            feedbacks: [],
            variaveis: [
              {'nome': 'Barba', 'preco': 40.0},
              {'nome': 'Cabelo', 'preco': 60.0},
              {'nome': 'Barba + Cabelo', 'preco': 90.0},
            ],
          ),
          _buildPostCard(
            profileUrl: 'https://randomuser.me/api/portraits/women/65.jpg',
            name: 'Spa das Mãos',
            distance: '900 m de você',
            imageUrl: 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f',
            title: 'Esmalte esmeralda',
            description: 'Esmalte preferido da Virgínia.',
            isProduto: true,
            preco: 'R\$ 40,00',
            precoEntrega: 'R\$ 10,00',
            empresa: 'Spa das Mãos',
            categorias: ['Unhas'],
            relacionados: [],
            feedbacks: [],
            variaveis: [
              {'nome': '5ml', 'preco': 40.0},
              {'nome': '10ml', 'preco': 70.0},
            ],
          ),
          _buildPostCard(
            profileUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
            name: 'Barbearia Top',
            distance: '3,1 km de você',
            imageUrl: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
            title: 'Pomada Modeladora',
            description: 'Produto de alta fixação para modelar seu cabelo.',
            isProduto: true,
            preco: 'R\$ 25,00',
            precoEntrega: 'R\$ 7,00',
            empresa: 'Barbearia Top',
            categorias: ['Cabelo', 'Pomada'],
            relacionados: [],
            feedbacks: [],
            variaveis: [
              {'nome': 'Normal', 'preco': 25.0},
              {'nome': 'Extra Forte', 'preco': 35.0},
            ],
          ),
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
