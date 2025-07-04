import 'package:flutter/material.dart';
import 'dart:async';

class TelaApresentacao extends StatefulWidget {
  const TelaApresentacao({super.key});

  @override
  State<TelaApresentacao> createState() => _TelaApresentacaoState();
}

class _TelaApresentacaoState extends State<TelaApresentacao>
    with TickerProviderStateMixin {
  double opacidade = 0.0;
  late AnimationController _gradienteController;
  late AnimationController _logoController;
  late AnimationController _textoFadeController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _textoFadeAnimation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Animação da logo agora cresce do pequeno para o tamanho normal
    _logoScaleAnimation = Tween<double>(begin: 0.65, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _logoController.forward();

    _textoFadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _textoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textoFadeController, curve: Curves.easeIn),
    );

    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _textoFadeController.forward();
      }
    });

    _gradienteController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        opacidade = 1.0;
      });
    });

    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textoFadeController.dispose();
    _gradienteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 2),
          opacity: opacidade,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _logoScaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _logoScaleAnimation.value,
                    child: Image.asset('lib/assets/logo_estetify.png', height: 155),
                  );
                },
              ),
              const SizedBox(height: 10),
              FadeTransition(
                opacity: _textoFadeAnimation,
                child: AnimatedBuilder(
                  animation: _gradienteController,
                  builder: (context, child) {
                    return ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment(-1.0 + 2.0 * _gradienteController.value, 0),
                          end: Alignment(1.0 + 2.0 * _gradienteController.value, 0),
                          colors: const [
                            Color(0xFF2C3E50),
                            Color(0xFFFF7043),
                            Color(0xFF2C3E50),
                            Color(0xFFFF7043),
                          ],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.srcIn,
                      child: const Text(
                        "Estetify: realce sua beleza, transforme sua rotina, celebre o melhor de você.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
