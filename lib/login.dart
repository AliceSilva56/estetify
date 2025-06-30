import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  void _loginComEmail() {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      final senha = senhaController.text;

      // Aqui você faz a autenticação com backend ou Firebase
      print('Login com e-mail: $email e senha: $senha');
      Navigator.pushReplacementNamed(context, '/principal');
    }
  }

  Future<void> _loginComGoogle() async {
    final googleSignIn = GoogleSignIn();
    final conta = await googleSignIn.signIn();

    if (conta != null) {
      print('Usuário do Google: ${conta.email}');
      // Aqui você usaria firebase_auth para autenticar
      Navigator.pushReplacementNamed(context, '/principal');
    }
  }

  void _loginComFacebook() {
    // Simulação: você pode integrar com `flutter_facebook_auth`
    print("Login com Facebook");
    Navigator.pushReplacementNamed(context, '/principal');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Column(
            children: [
              Image.asset('lib/assets/logo_estetify.png', height: 155),
              const SizedBox(height: 12),
              const Text(
                'Estetify',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe o e-mail';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
                          return 'Email inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: senhaController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Senha'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe a senha';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _loginComEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                      ),
                      child: const Text("Login", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text("Entrar com"),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _loginComGoogle,
                    icon: const Icon(Icons.g_mobiledata, size: 40),
                  ),
                  const SizedBox(width: 30),
                  IconButton(
                    onPressed: _loginComFacebook,
                    icon: const Icon(Icons.facebook, size: 36),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // Lógica para recuperação de senha
                      print("Esqueceu a senha");
                    },
                    child: const Text("Esqueceu a senha?", style: TextStyle(color: Colors.redAccent)),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/escolha_cadastro');
                    },
                    child: const Text("Criar conta", style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Text(
                "Política de Privacidade",
                style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
