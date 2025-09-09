import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'home.dart';

class CarrinhoAgendaScreen extends StatefulWidget {
  const CarrinhoAgendaScreen({super.key});

  @override
  State<CarrinhoAgendaScreen> createState() => _CarrinhoAgendaScreenState();
}

class _CarrinhoAgendaScreenState extends State<CarrinhoAgendaScreen> {
  int _currentIndex = 1;
  bool _showAgenda = false;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Mock data para exemplo
  final List<Map<String, dynamic>> produtos = [
    {
      "title": "Kit de produtos",
      "subtitle": "Estúdio Shine",
      "price": 150.0,
      "imagePath": "https://i.imgur.com/qZD5eOw.png",
      "quantidade": 1,
      "isProduto": true,
    },
  ];
  final List<Map<String, dynamic>> servicos = [
    {
      "title": "Sobrancelhas",
      "subtitle": "Estúdio Glam",
      "price": 60.0,
      "imagePath": "https://i.imgur.com/zHqFzYI.png",
      "date": "24/04/2024",
      "isProduto": false,
    },
    {
      "title": "Maquiagem",
      "subtitle": "Espaço Afroelegante",
      "price": 160.0,
      "imagePath": "https://i.imgur.com/oVU0cHn.png",
      "date": "25/04/2024",
      "isProduto": false,
    },
    {
      "title": "Depilação",
      "subtitle": "Studio Suavidade",
      "price": 90.0,
      "imagePath": "https://i.imgur.com/U5vO8Br.png",
      "date": "26/04/2024",
      "isProduto": false,
    },
  ];

  void _onTabTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TelaHome()),
      );
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _showCardMenu(int idx, bool isProduto) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: Text(isProduto ? 'Editar quantidade' : 'Editar agendamento'),
            onTap: () {
              Navigator.pop(context);
              // Ação de editar (não implementada)
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Excluir', style: TextStyle(color: Colors.red)),
            onTap: () {
              setState(() {
                if (isProduto) {
                  produtos.removeAt(idx);
                } else {
                  servicos.removeAt(idx);
                }
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  double get subtotalProdutos =>
      produtos.fold(0.0, (s, p) => s + (p['price'] as double) * (p['quantidade'] as int));
  double get subtotalServicos =>
      servicos.fold(0.0, (s, p) => s + (p['price'] as double));
  double get total => subtotalProdutos + subtotalServicos;

  @override
  Widget build(BuildContext context) {
    const azul = Color(0xFF2c3e50);
    const laranja = Color(0xFFFF7043);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: laranja,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Carrinho e Agenda',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              setState(() {
                _showAgenda = true;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                const Text(
                  "Revise seus serviços agendados e produtos antes de finalizar",
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 16),
                // Seção de Produtos
                if (produtos.isNotEmpty) ...[
                  const Text("Produtos no carrinho", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...List.generate(produtos.length, (i) => _buildCard(
                    idx: i,
                    title: produtos[i]['title'],
                    subtitle: produtos[i]['subtitle'],
                    imagePath: produtos[i]['imagePath'],
                    price: produtos[i]['price'],
                    quantidade: produtos[i]['quantidade'],
                    isProduto: true,
                    onMenu: () => _showCardMenu(i, true),
                  )),
                  const SizedBox(height: 12),
                ],
                // Seção de Serviços
                if (servicos.isNotEmpty) ...[
                  const Text("Serviços no carrinho", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...List.generate(servicos.length, (i) => _buildCard(
                    idx: i,
                    title: servicos[i]['title'],
                    subtitle: servicos[i]['subtitle'],
                    imagePath: servicos[i]['imagePath'],
                    price: servicos[i]['price'],
                    data: servicos[i]['date'],
                    isProduto: false,
                    onMenu: () => _showCardMenu(i, false),
                  )),
                  const SizedBox(height: 12),
                ],
                if (produtos.isNotEmpty || servicos.isNotEmpty) ...[
                  const Divider(height: 32, thickness: 1.2),
                  if (produtos.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Subtotal produtos:", style: TextStyle(fontWeight: FontWeight.w500)),
                        Text("R\$${subtotalProdutos.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  if (servicos.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Subtotal serviços:", style: TextStyle(fontWeight: FontWeight.w500)),
                        Text("R\$${subtotalServicos.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text("R\$${total.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: laranja)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: laranja,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    child: const Text("Finalizar compra", style: TextStyle(fontSize: 16)),
                  ),
                ],
              ],
            ),
          ),
          if (_showAgenda)
            DraggableScrollableSheet(
              initialChildSize: 1,
              minChildSize: 0.5,
              maxChildSize: 1,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text('Agenda', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => setState(() => _showAgenda = false),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: TableCalendar(
                                firstDay: DateTime.utc(2020, 1, 1),
                                lastDay: DateTime.utc(2030, 12, 31),
                                focusedDay: _focusedDay,
                                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                                onDaySelected: (selectedDay, focusedDay) {
                                  setState(() {
                                    _selectedDay = selectedDay;
                                    _focusedDay = focusedDay;
                                  });
                                },
                                calendarStyle: const CalendarStyle(
                                  todayDecoration: BoxDecoration(
                                    color: Color(0xFFFF7043),
                                    shape: BoxShape.circle,
                                  ),
                                  selectedDecoration: BoxDecoration(
                                    color: Color(0xFFa8e7cf),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text('Serviços agendados', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            ...List.generate(servicos.length, (i) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: _buildCard(
                                idx: i,
                                title: servicos[i]['title'],
                                subtitle: servicos[i]['subtitle'],
                                imagePath: servicos[i]['imagePath'],
                                price: servicos[i]['price'],
                                data: servicos[i]['date'],
                                isProduto: false,
                                onMenu: () => _showCardMenu(i, false),
                              ),
                            )),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: laranja,
        unselectedItemColor: azul,
        showUnselectedLabels: true,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Agenda'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _buildCard({
    required int idx,
    required String title,
    required String subtitle,
    required String imagePath,
    required double price,
    String? data,
    int? quantidade,
    required bool isProduto,
    required VoidCallback onMenu,
  }) {
    const verde = Color(0xFFa8e7cf);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: verde, width: 2),
        borderRadius: BorderRadius.circular(14),
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imagePath,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    width: 64,
                    height: 64,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image, size: 32),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        // Botão de 3 pontos
                        IconButton(
                          icon: const Icon(Icons.more_vert, size: 22),
                          onPressed: onMenu,
                          splashRadius: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Divider(height: 8, thickness: 1),
                    Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                    // Data ou quantidade
                    Padding(
                      padding: const EdgeInsets.only(top: 6, bottom: 2),
                      child: isProduto
                          ? Row(
                              children: [
                                const Text('Quantidade:', style: TextStyle(fontSize: 13)),
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(Icons.remove, size: 18),
                                  onPressed: quantidade! > 1
                                      ? () {
                                          setState(() {
                                            produtos[idx]['quantidade']--;
                                          });
                                        }
                                      : null,
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                ),
                                Text('$quantidade', style: const TextStyle(fontSize: 14)),
                                IconButton(
                                  icon: const Icon(Icons.add, size: 18),
                                  onPressed: () {
                                    setState(() {
                                      produtos[idx]['quantidade']++;
                                    });
                                  },
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16, color: verde),
                                const SizedBox(width: 4),
                                Text(data ?? '', style: const TextStyle(fontSize: 13)),
                              ],
                            ),
                    ),
                    // Preço no canto inferior direito
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "R\$${isProduto ? (price * quantidade!).toStringAsFixed(2) : price.toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFFF7043)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
