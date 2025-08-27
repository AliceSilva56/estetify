import 'package:flutter/material.dart';

class EscolhaTipoUsuarioPage extends StatelessWidget {
  const EscolhaTipoUsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Cores do README.md
    const azul = Color(0xFF2c3e50);
    const laranja = Color(0xFFFF7043);
    const verde = Color(0xFFa8e7cf);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: laranja,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/login')
        ),
        title: const Text(
          'Estetify',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            const Text(
              'Que tipo de conta quer criar?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: azul),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/cadastro_consumidor');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: verde,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: azul, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: azul.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/consumidor.png',
                            height: 70,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Consumidor',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: azul),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Quero agendar serviços e comprar produtos',
                            style: TextStyle(fontSize: 13, color: azul),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/cadastro_empresario');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: laranja,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: azul, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: azul.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/empresario.png',
                            height: 70,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Empresário',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: azul),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Quero oferecer serviços ou vender produtos',
                            style: TextStyle(fontSize: 13, color: azul),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
