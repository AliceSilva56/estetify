import 'package:flutter/material.dart';
import 'apresentacao.dart';
import 'login.dart';
import 'anonimo.dart';
import 'home.dart';
import 'escolha_cadastro.dart';
import 'cadastro_consumidor.dart';
import 'cadastro_empresario.dart';

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
        '/escolha_cadastro': (context) => const EscolhaTipoUsuarioPage(),
        '/cadastro_consumidor': (context) => const CadastroConsumidorPage(),
        '/cadastro_empresario': (context) => const CadastroEmpresarioPage(),
        '/login': (context) => TelaLogin(),
        '/anonimo': (context) => TelaAnonimo(),
        '/principal': (context) => TelaHome(),
      },
    );
  }
}
