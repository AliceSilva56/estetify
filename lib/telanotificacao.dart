import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Notificação',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              NotificationCard(
                icon: Icons.access_time,
                iconColor: const Color(0xFFF6A540),
                title: 'Lembrete de compromisso',
                subtitle: 'Sua reunião começa em 10 minutos',
                time: 'Agora mesmo',
              ),
              const SizedBox(height: 16),
              NotificationCard(
                icon: Icons.calendar_month,
                iconColor: const Color(0xFFF4655F),
                title: 'Agenda atualizada',
                subtitle: 'Sua agenda foi atualizada 15/12/25',
                time: 'Ontem',
              ),
              const SizedBox(height: 16),
              NotificationCard(
                icon: Icons.flash_on,
                iconColor: const Color(0xFF70D09B),
                title: 'Promoção relâmpago',
                subtitle: 'Descontos especiais por tempo limitado',
                time: '10 min atrás',
              ),
              const SizedBox(height: 16),
              NotificationCard(
                icon: Icons.credit_card,
                iconColor: const Color(0xFF4DB6AC),
                title: 'Pagamento confirmado',
                subtitle: 'Serviço pago com sucesso',
                time: 'Agora mesmo',
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String time;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}