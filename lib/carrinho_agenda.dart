import 'package:flutter/material.dart';
import 'principal.dart';

class CarrinhoAgendaScreen extends StatefulWidget {
  const CarrinhoAgendaScreen({super.key});

  @override
  State<CarrinhoAgendaScreen> createState() => _CarrinhoAgendaScreenState();
}

class _CarrinhoAgendaScreenState extends State<CarrinhoAgendaScreen> {
  int _currentIndex = 1;

  void _onTabTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TelaPrincipal()),
      );
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const azul = Color(0xFF2c3e50);
    const laranja = Color(0xFFFF7043);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Carrinho e Agenda',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "Revise seus serviços agendados e produtos antes de finalizar",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),

            const Text("Serviços agendados", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            _buildCard(
              title: "Sobrancelhas",
              subtitle: "Estúdio Glam",
              date: "24/04",
              price: "R\$60,00",
              imagePath: "https://i.imgur.com/zHqFzYI.png",
              showEdit: true,
            ),
            _buildCard(
              title: "Maquiagem",
              subtitle: "Espaço Afroelegante",
              price: "R\$160,00",
              imagePath: "https://i.imgur.com/oVU0cHn.png",
            ),
            _buildCard(
              title: "Kit de produtos",
              subtitle: "Estúdio Shine",
              price: "R\$150,00",
              imagePath: "https://i.imgur.com/qZD5eOw.png",
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

            const SizedBox(height: 24),
            const Text("Agenda", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            _buildCard(
              title: "Sobrancelhas",
              subtitle: "Estúdio Glam",
              price: "R\$60,00",
              imagePath: "https://i.imgur.com/zHqFzYI.png",
            ),
            _buildCard(
              title: "Depilação",
              subtitle: "Studio Suavidade",
              price: "R\$90,00",
              imagePath: "https://i.imgur.com/U5vO8Br.png",
            ),
          ],
        ),
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
    required String title,
    required String subtitle,
    required String imagePath,
    required String price,
    String? date,
    bool showEdit = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green.shade100),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imagePath,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
                if (showEdit || date != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (showEdit)
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.edit, size: 16, color: Colors.orange),
                          label: const Text(
                            "Editar",
                            style: TextStyle(fontSize: 12, color: Colors.orange),
                          ),
                        ),
                      if (date != null)
                        Text(date!, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(price, style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
