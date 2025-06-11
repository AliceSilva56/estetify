import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  double _opacidade = 0;
  double _espacoCima = 80;

  String _tipoUsuario = 'Usuário';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _opacidade = 1;
        _espacoCima = 0;
      });
    });
  }

  void _validarCadastro() {
    if (_formKey.currentState!.validate()) {
      // Aqui você pode salvar os dados se quiser
      Navigator.pushNamed(context, '/principal'); // Navega para a tela principal
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: Center(
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 800),
          padding: EdgeInsets.only(top: _espacoCima),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: _opacidade,
            child: Card(
              color: const Color(0xFFEABF9F),
              elevation: 12,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _nomeController,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          prefixIcon: Icon(Icons.person),
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        style: const TextStyle(color: Colors.black),
                        validator: (valor) {
                          if (valor == null || valor.isEmpty) return 'Informe seu nome';
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          prefixIcon: Icon(Icons.email),
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        style: const TextStyle(color: Colors.black),
                        validator: (valor) {
                          if (valor == null || valor.isEmpty) return 'Informe seu e-mail';
                          if (!valor.contains('@')) return 'E-mail inválido';
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _senhaController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          prefixIcon: Icon(Icons.lock),
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        style: const TextStyle(color: Colors.black),
                        validator: (valor) {
                          if (valor == null || valor.isEmpty) return 'Informe sua senha';
                          if (valor.length < 6) return 'Senha muito curta';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Tipo de usuário com Radio Buttons
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tipo de Conta:',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          const SizedBox(height: 8), // Espaço entre o texto e os Radio Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Radio<String>(
                                    value: 'Usuário',
                                    groupValue: _tipoUsuario,
                                    activeColor: Colors.black,
                                    onChanged: (valor) {
                                      setState(() {
                                        _tipoUsuario = valor!;
                                      });
                                    },
                                  ),
                                  const Text('Usuário', style: TextStyle(color: Colors.black)),
                                ],
                              ),
                              const SizedBox(width: 20), // Espaço entre os Radio Buttons
                              Row(
                                children: [
                                  Radio<String>(
                                    value: 'Empreendedor',
                                    groupValue: _tipoUsuario,
                                    activeColor: Colors.black,
                                    onChanged: (valor) {
                                      setState(() {
                                        _tipoUsuario = valor!;
                                      });
                                    },
                                  ),
                                  const Text('Empreendedor', style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _validarCadastro,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7CB9E8),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text("Cadastrar"),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 40),
                        ),
                        child: const Text("Já tenho conta!"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
