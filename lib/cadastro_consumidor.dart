import 'package:flutter/material.dart';

class CadastroConsumidorPage extends StatefulWidget {
  const CadastroConsumidorPage({super.key});

  @override
  State<CadastroConsumidorPage> createState() => _CadastroConsumidorPageState();
}

class _CadastroConsumidorPageState extends State<CadastroConsumidorPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();
  bool _aceitaTermos = false;
  bool _senhaVisivel = false;
  bool _confirmaSenhaVisivel = false;
  String? _erro;

  void _cadastrar() {
    setState(() {
      _erro = null;
    });
    if (_formKey.currentState!.validate()) {
      if (!_aceitaTermos) {
        setState(() {
          _erro = 'Você deve aceitar os Termos de Uso e a Política de Privacidade.';
        });
        return;
      }
      // TODO: Implementar cadastro real
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    const azul = Color(0xFF2c3e50);
    const laranja = Color(0xFFFF7043);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: laranja,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Cadastro Consumidor', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome completo',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Informe seu nome completo' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe seu e-mail';
                  if (!RegExp(r'^.+@.+\..+').hasMatch(v)) return 'E-mail inválido';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _senhaController,
                obscureText: !_senhaVisivel,
                decoration: InputDecoration(
                  labelText: 'Senha (mínimo 8 caracteres)',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_senhaVisivel ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _senhaVisivel = !_senhaVisivel),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe uma senha';
                  if (v.length < 8) return 'A senha deve ter pelo menos 8 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmaSenhaController,
                obscureText: !_confirmaSenhaVisivel,
                decoration: InputDecoration(
                  labelText: 'Confirmação de senha',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_confirmaSenhaVisivel ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _confirmaSenhaVisivel = !_confirmaSenhaVisivel),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Confirme sua senha';
                  if (v != _senhaController.text) return 'As senhas não coincidem';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _aceitaTermos,
                    onChanged: (v) => setState(() => _aceitaTermos = v ?? false),
                  ),
                  const Expanded(
                    child: Text('Li e aceito os Termos de Uso e a Política de Privacidade'),
                  ),
                ],
              ),
              if (_erro != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(_erro!, style: const TextStyle(color: Colors.red)),
                ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _cadastrar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: laranja,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Cadastrar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Voltar ao Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}