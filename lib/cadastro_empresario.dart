import 'package:flutter/material.dart';

class CadastroEmpresarioPage extends StatefulWidget {
  const CadastroEmpresarioPage({super.key});

  @override
  State<CadastroEmpresarioPage> createState() => _CadastroEmpresarioPageState();
}

class _CadastroEmpresarioPageState extends State<CadastroEmpresarioPage> {
  int _etapa = 0; // 0: escolha, 1: autônomo, 2: empreendedor

  void _irParaAutonomo() {
    setState(() => _etapa = 1);
  }
  void _irParaEmpreendedor() {
    setState(() => _etapa = 2);
  }
  void _voltar() {
    if (_etapa == 0) {
      Navigator.pop(context);
    } else {
      setState(() => _etapa = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    const azul = Color(0xFF2c3e50);
    const laranja = Color(0xFFFF7043);
    const verde = Color(0xFFa8e7cf);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: azul,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _voltar,
        ),
        title: const Text('Cadastro Empresário', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _etapa == 0
            ? _buildEscolha(context, azul, laranja, verde)
            : _etapa == 1
                ? CadastroAutonomoWidget(onVoltar: _voltar)
                : CadastroEmpreendedorWidget(onVoltar: _voltar),
      ),
    );
  }

  Widget _buildEscolha(BuildContext context, Color azul, Color laranja, Color verde) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
           Text(
            'Qual o seu perfil?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: azul),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _irParaAutonomo,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: verde,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: azul, width: 2),
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/autonomo.png', height: 70, fit: BoxFit.contain),
                        const SizedBox(height: 12),
                         Text('Autônomo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: azul)),
                        const SizedBox(height: 4),
                         Text('Profissional individual', style: TextStyle(fontSize: 13, color: azul), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: GestureDetector(
                  onTap: _irParaEmpreendedor,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: laranja,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: azul, width: 2),
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/empreendedor.png', height: 70, fit: BoxFit.contain),
                        const SizedBox(height: 12),
                         Text('Empreendedor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: azul)),
                        const SizedBox(height: 4),
                         Text('Empresa ou salão', style: TextStyle(fontSize: 13, color: azul), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Os widgets CadastroAutonomoWidget e CadastroEmpreendedorWidget serão implementados nos próximos passos.
class CadastroAutonomoWidget extends StatelessWidget {
  final VoidCallback onVoltar;
  const CadastroAutonomoWidget({required this.onVoltar, super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Formulário Autônomo (implementar)'));
  }
}
class CadastroEmpreendedorWidget extends StatelessWidget {
  final VoidCallback onVoltar;
  const CadastroEmpreendedorWidget({required this.onVoltar, super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Formulário Empreendedor (implementar)'));
  }
}
