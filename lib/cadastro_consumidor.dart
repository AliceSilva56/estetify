import 'package:flutter/material.dart';

class CadastroConsumidorPage extends StatefulWidget {
  const CadastroConsumidorPage({super.key});

  @override
  State<CadastroConsumidorPage> createState() => _CadastroConsumidorPageState();
}

class _CadastroConsumidorPageState extends State<CadastroConsumidorPage> {
  int _etapa = 0;
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _cpfController = TextEditingController();
  bool _aceitaTermos = false;
  bool _senhaVisivel = false;
  bool _confirmaSenhaVisivel = false;
  String? _erro;
  String? _genero;
  String? _fotoPerfilUrl;

  // Preferências
  final List<String> _preferenciasServicos = [];
  final List<String> _preferenciasProdutos = [];
  final List<String> _categoriasServicos = [
    'Cabelo', 'Unhas', 'Depilação', 'Maquiagem', 'Massagem', 'Sobrancelha', 'Barba', 'Estética facial', 'Estética corporal'
  ];
  final List<String> _categoriasProdutos = [
    'Shampoo', 'Condicionador', 'Esmalte', 'Cremes', 'Óleos', 'Maquiagem', 'Acessórios', 'Pomada', 'Perfume'
  ];

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

  void _avancar() {
    if (_formKey.currentState!.validate()) {
      setState(() => _etapa++);
    }
  }
  void _voltar() {
    setState(() => _etapa--);
  }

  Widget _buildProgressBar() {
    const etapas = 3;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(etapas, (i) => Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: i <= _etapa ? const Color(0xFFFF7043) : Colors.white,
                border: Border.all(color: const Color(0xFFFF7043), width: 2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('${i + 1}', style: TextStyle(
                  color: i <= _etapa ? Colors.white : const Color(0xFFFF7043),
                  fontWeight: FontWeight.bold)),
              ),
            ),
            if (i < etapas - 1)
              Container(
                width: 32,
                height: 4,
                color: i < _etapa ? const Color(0xFFFF7043) : Colors.grey[300],
              ),
          ],
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const laranja = Color(0xFFFF7043);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: laranja,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: _etapa > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: _voltar,
              )
            : IconButton(
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
              _buildProgressBar(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  final offset = _etapa > 0 ? const Offset(1, 0) : const Offset(-1, 0);
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: offset,
                      end: Offset.zero,
                    ).animate(animation),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                child: Builder(
                  key: ValueKey(_etapa),
                  builder: (context) {
                    if (_etapa == 0) {
                      return Column(
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
                            controller: _cpfController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'CPF',
                              prefixIcon: Icon(Icons.badge),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Informe seu CPF';
                              if (!RegExp(r'\d{3}\.\d{3}\.\d{3}-\d{2}').hasMatch(v)) return 'CPF inválido (formato: 000.000.000-00)';
                              return null;
                            },
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
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.g_mobiledata, color: Colors.white),
                                label: const Text('Google'),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.facebook, color: Colors.white),
                                label: const Text('Facebook'),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _avancar,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: laranja,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 48),
                            ),
                            child: const Text('Próxima etapa'),
                          ),
                        ],
                      );
                    } else if (_etapa == 1) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                _fotoPerfilUrl = 'https://randomuser.me/api/portraits/men/1.jpg';
                              });
                            },
                            child: Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: _fotoPerfilUrl != null ? NetworkImage(_fotoPerfilUrl!) : null,
                                child: _fotoPerfilUrl == null ? const Icon(Icons.add_a_photo, size: 40, color: Colors.white70) : null,
                                backgroundColor: laranja,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _telefoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Telefone',
                              prefixIcon: Icon(Icons.phone),
                            ),
                            validator: (v) => v == null || v.isEmpty ? 'Informe seu telefone' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _dataNascimentoController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'Data de nascimento',
                              prefixIcon: Icon(Icons.cake),
                            ),
                            onTap: () async {
                              final data = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2000),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (data != null) {
                                _dataNascimentoController.text = '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
                              }
                            },
                            validator: (v) => v == null || v.isEmpty ? 'Informe sua data de nascimento' : null,
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _genero,
                            items: const [
                              DropdownMenuItem(value: 'Cis', child: Text('Cis')),
                              DropdownMenuItem(value: 'Trans', child: Text('Trans')),
                              DropdownMenuItem(value: 'Não-binário', child: Text('Não-binário')),
                              DropdownMenuItem(value: 'Outro', child: Text('Outro')),
                            ],
                            onChanged: (v) => setState(() => _genero = v),
                            decoration: const InputDecoration(
                              labelText: 'Gênero',
                              prefixIcon: Icon(Icons.wc),
                            ),
                            validator: (v) => v == null || v.isEmpty ? 'Selecione seu gênero' : null,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _avancar,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: laranja,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 48),
                            ),
                            child: const Text('Próxima etapa'),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 16),
                          const Text('Preferências de Serviços', style: TextStyle(fontWeight: FontWeight.bold)),
                          ..._categoriasServicos.map((cat) => CheckboxListTile(
                            value: _preferenciasServicos.contains(cat),
                            onChanged: (v) => setState(() => v == true ? _preferenciasServicos.add(cat) : _preferenciasServicos.remove(cat)),
                            title: Text(cat),
                          )),
                          const SizedBox(height: 16),
                          const Text('Preferências de Produtos', style: TextStyle(fontWeight: FontWeight.bold)),
                          ..._categoriasProdutos.map((cat) => CheckboxListTile(
                            value: _preferenciasProdutos.contains(cat),
                            onChanged: (v) => setState(() => v == true ? _preferenciasProdutos.add(cat) : _preferenciasProdutos.remove(cat)),
                            title: Text(cat),
                          )),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _voltar,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(double.infinity, 48),
                                  ),
                                  child: const Text('Voltar'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _cadastrar,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: laranja,
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(double.infinity, 48),
                                  ),
                                  child: const Text('Finalizar cadastro'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              if (_erro != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(_erro!, style: const TextStyle(color: Colors.red)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}