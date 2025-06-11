import 'package:flutter/material.dart';

class TelaAnonimo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // fundo neutro claro
      appBar: AppBar(
        title: const Text("Modo Anônimo"),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.visibility_off, size: 80, color: Colors.grey),
              const SizedBox(height: 20),
              const Text(
                "Você está navegando como visitante.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                "Alguns recursos estão desativados no modo anônimo. Faça login ou cadastre-se para ter acesso completo ao Estetify.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7CB9E8),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Fazer Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
