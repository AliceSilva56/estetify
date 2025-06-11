import 'package:flutter/material.dart';
import 'apresentacao.dart';
import 'login.dart';
import 'cadastro.dart';
import 'anonimo.dart';
import 'principal.dart';

void main() {
  runApp(const EstetifyApp());
}

class EstetifyApp extends StatelessWidget {
  const EstetifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Estetify',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const TelaApresentacao(),
        '/login': (context) => TelaLogin(),
        '/cadastro': (context) => const TelaCadastro(),
        '/anonimo': (context) => TelaAnonimo(),
        '/principal': (context) => TelaPrincipal(),
      },
    );
  }
}
