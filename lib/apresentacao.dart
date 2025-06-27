import 'package:flutter/material.dart';
import 'dart:async';

class TelaApresentacao extends StatefulWidget {
  const TelaApresentacao({super.key});

  @override
  State<TelaApresentacao> createState() => _TelaApresentacaoState();
}

class _TelaApresentacaoState extends State<TelaApresentacao>
    with SingleTickerProviderStateMixin {
  double opacidade = 0.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Controlador do gradiente animado
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    // Aparecimento do conteúdo
    Timer(const Duration(milliseconds: 500), () {
      setState(() { 
        opacidade = 1.0; // Aumenta a opacidade para 1 após 500ms
      });
    });

    // Navegar automaticamente
    Timer(const Duration(seconds: 10),  () { // Após 7 segundos, navega para a tela de login
      Navigator.pushReplacementNamed(context, '/login'); // Navega para a tela de login
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Cor de fundo
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 2), // Duração da animação de opacidade
          opacity: opacidade,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('lib/assets/logo_estetify.png', height: 155),
              const SizedBox(height: 20),

              // Frase com gradiente animado horizontalmente
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment(-1.0 + 2.0 * _controller.value, 0),
                        end: Alignment(1.0 + 2.0 * _controller.value, 0),
                        colors: const [
                          Color(0xFF7CB9E8), // Aero
                          Color(0xFFFABA82), // Rajah
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: const Text(
                      "Estetify: realce sua beleza, transforme sua rotina, celebre o melhor de você.",
                      //"Estetify é mais que um app - é o lembrete diário de que cuidar de si mesmo é uma prioridade",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.white, // necessário para o ShaderMask
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
