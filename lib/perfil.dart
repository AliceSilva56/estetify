import 'package:flutter/material.dart';


class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Perfil',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // Foto do perfil
          Center(
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.blue,
              child: CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/women/44.jpg',
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Amanda Silva',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Configurações',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Botões de configuração
          const PerfilOption(
            icon: Icons.notifications,
            label: 'Notificações',
          ),
          const PerfilOption(
            icon: Icons.favorite,
            label: 'Favoritos',
          ),
          const PerfilOption(
            icon: Icons.palette,
            label: 'Personalização',
          ),
          const PerfilOption(
            icon: Icons.history,
            label: 'Histórico',
          ),
          const PerfilOption(
            icon: Icons.privacy_tip,
            label: 'Política de privacidade',
          ),
        ],
      ),
    );
  }
}

class PerfilOption extends StatelessWidget {
  final IconData icon;
  final String label;

  const PerfilOption({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.orange),
          title: Text(label),
          onTap: () {
            // Ação ao clicar na opção
          },
        ),
      ),
    );
  }
}

