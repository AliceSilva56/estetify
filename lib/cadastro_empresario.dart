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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2c3e50),
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
            ? _buildEscolha(context)
            : _etapa == 1
                ? CadastroAutonomoWidget(onVoltar: _voltar)
                : CadastroEmpreendedorWidget(onVoltar: _voltar),
      ),
    );
  }

  Widget _buildEscolha(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
           Text(
            'Qual o seu perfil?',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2c3e50)),
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
                      color: const Color(0xFFa8e7cf),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFF2c3e50), width: 2),
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/autonomo.png', height: 70, fit: BoxFit.contain),
                        const SizedBox(height: 12),
                         Text('Autônomo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: const Color(0xFF2c3e50))),
                        const SizedBox(height: 4),
                         Text('Profissional individual', style: TextStyle(fontSize: 13, color: const Color(0xFF2c3e50)), textAlign: TextAlign.center),
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
                      color: const Color(0xFFFF7043),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFF2c3e50), width: 2),
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/empreendedor.png', height: 70, fit: BoxFit.contain),
                        const SizedBox(height: 12),
                         Text('Empreendedor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: const Color(0xFF2c3e50))),
                        const SizedBox(height: 4),
                         Text('Empresa ou salão', style: TextStyle(fontSize: 13, color: const Color(0xFF2c3e50)), textAlign: TextAlign.center),
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

class CadastroAutonomoWidget extends StatefulWidget {
  final VoidCallback onVoltar;
  const CadastroAutonomoWidget({required this.onVoltar, super.key});
  @override
  State<CadastroAutonomoWidget> createState() => _CadastroAutonomoWidgetState();
}

class _CadastroAutonomoWidgetState extends State<CadastroAutonomoWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _nomeSocialController = TextEditingController();
  final _cpfController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  String? _genero;
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();
  bool _senhaVisivel = false;
  bool _confirmaSenhaVisivel = false;
  bool _aceitaTermos = false;
  // Endereço
  String? _tipoAtendimento;
  final _ruaController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  String? _estado;
  final _cepController = TextEditingController();
  // Atendimento
  final List<String> _tiposAtendimento = [];
  // Conta
  String? _tipoPix;
  final _chavePixController = TextEditingController();
  String? _banco;
  final _agenciaController = TextEditingController();
  final _contaController = TextEditingController();
  String? _erro;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: widget.onVoltar,
                ),
                const Text('Dados Pessoais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome completo'),
              validator: (v) => v == null || v.isEmpty ? 'Informe seu nome completo' : null,
            ),
            TextFormField(
              controller: _nomeSocialController,
              decoration: const InputDecoration(labelText: 'Nome social (opcional)'),
            ),
            TextFormField(
              controller: _cpfController,
              decoration: const InputDecoration(labelText: 'CPF (XXX.XXX.XXX-XX)'),
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Informe o CPF';
                if (!RegExp(r'\d{3}\.\d{3}\.\d{3}-\d{2}').hasMatch(v)) return 'CPF inválido';
                return null;
              },
            ),
            TextFormField(
              controller: _dataNascimentoController,
              decoration: const InputDecoration(labelText: 'Data de nascimento'),
              keyboardType: TextInputType.datetime,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                final data = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (data != null) {
                  _dataNascimentoController.text =
                      '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
                }
              },
            ),
            DropdownButtonFormField<String>(
              value: _genero,
              items: const [
                DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
                DropdownMenuItem(value: 'Feminino', child: Text('Feminino')),
                DropdownMenuItem(value: 'Outro', child: Text('Outro')),
                DropdownMenuItem(value: 'Prefiro não informar', child: Text('Prefiro não informar')),
              ],
              onChanged: (v) => setState(() => _genero = v),
              decoration: const InputDecoration(labelText: 'Gênero (opcional)'),
            ),
            TextFormField(
              controller: _telefoneController,
              decoration: const InputDecoration(labelText: 'Telefone celular com DDD'),
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Informe seu e-mail';
                if (!RegExp(r'^.+@.+\..+').hasMatch(v)) return 'E-mail inválido';
                return null;
              },
            ),
            TextFormField(
              controller: _senhaController,
              obscureText: !_senhaVisivel,
              decoration: InputDecoration(
                labelText: 'Senha (mín. 8 caracteres, maiúscula, número, símbolo)',
                suffixIcon: IconButton(
                  icon: Icon(_senhaVisivel ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _senhaVisivel = !_senhaVisivel),
                ),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Informe uma senha';
                if (v.length < 8) return 'A senha deve ter pelo menos 8 caracteres';
                if (!RegExp(r'[A-Z]').hasMatch(v)) return 'Inclua uma letra maiúscula';
                if (!RegExp(r'[0-9]').hasMatch(v)) return 'Inclua um número';
                if (!RegExp(r'[!@#\$&*~]').hasMatch(v)) return 'Inclua um símbolo';
                return null;
              },
            ),
            TextFormField(
              controller: _confirmaSenhaController,
              obscureText: !_confirmaSenhaVisivel,
              decoration: InputDecoration(
                labelText: 'Confirmar senha',
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
            const Divider(),
            const Text('Endereço de Atendimento', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            DropdownButtonFormField<String>(
              value: _tipoAtendimento,
              items: const [
                DropdownMenuItem(value: 'Domicílio', child: Text('Em domicílio')),
                DropdownMenuItem(value: 'Estúdio', child: Text('Em estúdio próprio')),
              ],
              onChanged: (v) => setState(() => _tipoAtendimento = v),
              decoration: const InputDecoration(labelText: 'Tipo de atendimento'),
            ),
            TextFormField(
              controller: _ruaController,
              decoration: const InputDecoration(labelText: 'Rua / número / complemento'),
            ),
            TextFormField(
              controller: _bairroController,
              decoration: const InputDecoration(labelText: 'Bairro'),
            ),
            TextFormField(
              controller: _cidadeController,
              decoration: const InputDecoration(labelText: 'Cidade'),
            ),
            DropdownButtonFormField<String>(
              value: _estado,
              items: const [
                DropdownMenuItem(value: 'SP', child: Text('SP')),
                DropdownMenuItem(value: 'RJ', child: Text('RJ')),
                DropdownMenuItem(value: 'MG', child: Text('MG')),
                DropdownMenuItem(value: 'RS', child: Text('RS')),
                DropdownMenuItem(value: 'PR', child: Text('PR')),
                DropdownMenuItem(value: 'SC', child: Text('SC')),
                DropdownMenuItem(value: 'BA', child: Text('BA')),
                DropdownMenuItem(value: 'PE', child: Text('PE')),
                DropdownMenuItem(value: 'CE', child: Text('CE')),
                DropdownMenuItem(value: 'GO', child: Text('GO')),
                DropdownMenuItem(value: 'DF', child: Text('DF')),
                // ... outros estados
              ],
              onChanged: (v) => setState(() => _estado = v),
              decoration: const InputDecoration(labelText: 'Estado (UF)'),
            ),
            TextFormField(
              controller: _cepController,
              decoration: const InputDecoration(labelText: 'CEP'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            // TODO: Integração Google Maps API para localização e raio de atendimento
            const Divider(),
            const Text('Tipos de atendimento oferecidos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            CheckboxListTile(
              value: _tiposAtendimento.contains('Tradicional'),
              onChanged: (v) => setState(() => v == true ? _tiposAtendimento.add('Tradicional') : _tiposAtendimento.remove('Tradicional')),
              title: const Text('Tradicional (no local)'),
            ),
            CheckboxListTile(
              value: _tiposAtendimento.contains('Domiciliar'),
              onChanged: (v) => setState(() => v == true ? _tiposAtendimento.add('Domiciliar') : _tiposAtendimento.remove('Domiciliar')),
              title: const Text('Domiciliar'),
            ),
            CheckboxListTile(
              value: _tiposAtendimento.contains('Humanizado'),
              onChanged: (v) => setState(() => v == true ? _tiposAtendimento.add('Humanizado') : _tiposAtendimento.remove('Humanizado')),
              title: const Text('Atendimento humanizado / acessível'),
            ),
            CheckboxListTile(
              value: _tiposAtendimento.contains('Noturno'),
              onChanged: (v) => setState(() => v == true ? _tiposAtendimento.add('Noturno') : _tiposAtendimento.remove('Noturno')),
              title: const Text('Atendimento noturno'),
            ),
            CheckboxListTile(
              value: _tiposAtendimento.contains('Exclusivo'),
              onChanged: (v) => setState(() => v == true ? _tiposAtendimento.add('Exclusivo') : _tiposAtendimento.remove('Exclusivo')),
              title: const Text('Atendimento por agendamento exclusivo'),
            ),
            const Divider(),
            const Text('Conta de Recebimento', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            DropdownButtonFormField<String>(
              value: _tipoPix,
              items: const [
                DropdownMenuItem(value: 'CPF', child: Text('CPF')),
                DropdownMenuItem(value: 'E-mail', child: Text('E-mail')),
                DropdownMenuItem(value: 'Telefone', child: Text('Telefone')),
                DropdownMenuItem(value: 'Aleatória', child: Text('Chave aleatória')),
              ],
              onChanged: (v) => setState(() => _tipoPix = v),
              decoration: const InputDecoration(labelText: 'Tipo de chave PIX'),
            ),
            TextFormField(
              controller: _chavePixController,
              decoration: const InputDecoration(labelText: 'Chave PIX'),
            ),
            DropdownButtonFormField<String>(
              value: _banco,
              items: const [
                DropdownMenuItem(value: 'Banco do Brasil', child: Text('Banco do Brasil')),
                DropdownMenuItem(value: 'Caixa', child: Text('Caixa')),
                DropdownMenuItem(value: 'Bradesco', child: Text('Bradesco')),
                DropdownMenuItem(value: 'Itaú', child: Text('Itaú')),
                DropdownMenuItem(value: 'Santander', child: Text('Santander')),
                DropdownMenuItem(value: 'Nubank', child: Text('Nubank')),
                DropdownMenuItem(value: 'Inter', child: Text('Inter')),
                DropdownMenuItem(value: 'Outros', child: Text('Outros')),
              ],
              onChanged: (v) => setState(() => _banco = v),
              decoration: const InputDecoration(labelText: 'Banco'),
            ),
            TextFormField(
              controller: _agenciaController,
              decoration: const InputDecoration(labelText: 'Agência'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _contaController,
              decoration: const InputDecoration(labelText: 'Número da conta (com dígito)'),
              keyboardType: TextInputType.number,
            ),
            const Divider(),
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
              onPressed: () {
                setState(() => _erro = null);
                if (_formKey.currentState!.validate()) {
                  if (!_aceitaTermos) {
                    setState(() => _erro = 'Você deve aceitar os Termos de Uso e a Política de Privacidade.');
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cadastro realizado!')),
                  );
                  widget.onVoltar();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7043),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Cadastrar profissional'),
            ),
            TextButton(
              onPressed: widget.onVoltar,
              child: const Text('Voltar para login'),
            ),
          ],
        ),
      ),
    );
  }
}

class CadastroEmpreendedorWidget extends StatefulWidget {
  final VoidCallback onVoltar;
  const CadastroEmpreendedorWidget({required this.onVoltar, super.key});
  @override
  State<CadastroEmpreendedorWidget> createState() => _CadastroEmpreendedorWidgetState();
}

class _CadastroEmpreendedorWidgetState extends State<CadastroEmpreendedorWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();
  final _razaoSocialController = TextEditingController();
  final _nomeFantasiaController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _inscricaoEstadualController = TextEditingController();
  final _ruaController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  String? _estado;
  final _cepController = TextEditingController();
  String? _tipoPix;
  final _chavePixController = TextEditingController();
  String? _banco;
  final _agenciaController = TextEditingController();
  final _contaController = TextEditingController();
  final List<String> _tiposAtendimento = [];
  bool _aceitaTermos = false;
  bool _senhaVisivel = false;
  bool _confirmaSenhaVisivel = false;
  String? _erro;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: widget.onVoltar,
                ),
                const Text('Dados da Empresa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Informe o e-mail';
                if (!RegExp(r'^.+@.+\..+').hasMatch(v)) return 'E-mail inválido';
                return null;
              },
            ),
            TextFormField(
              controller: _senhaController,
              obscureText: !_senhaVisivel,
              decoration: InputDecoration(
                labelText: 'Senha',
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
            TextFormField(
              controller: _confirmaSenhaController,
              obscureText: !_confirmaSenhaVisivel,
              decoration: InputDecoration(
                labelText: 'Verificação de senha',
                suffixIcon: IconButton(
                  icon: Icon(_confirmaSenhaVisivel ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _confirmaSenhaVisivel = !_confirmaSenhaVisivel),
                ),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Confirme sua senha';
                if (v != _senhaController.text) return 'As senhas digitadas não são iguais.';
                return null;
              },
            ),
            const Divider(),
            const Text('Dados da Empresa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            TextFormField(
              controller: _razaoSocialController,
              decoration: const InputDecoration(labelText: 'Nome da empresa (razão social)'),
              validator: (v) => v == null || v.isEmpty ? 'Informe a razão social' : null,
            ),
            TextFormField(
              controller: _nomeFantasiaController,
              decoration: const InputDecoration(labelText: 'Nome fantasia (opcional)'),
            ),
            TextFormField(
              controller: _cnpjController,
              decoration: const InputDecoration(labelText: 'CNPJ (XX.XXX.XXX/XXXX-XX)'),
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Informe o CNPJ';
                if (!RegExp(r'\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}').hasMatch(v)) return 'Informe um CNPJ válido.';
                return null;
              },
            ),
            TextFormField(
              controller: _inscricaoEstadualController,
              decoration: const InputDecoration(labelText: 'Inscrição estadual (opcional)'),
            ),
            TextFormField(
              controller: _ruaController,
              decoration: const InputDecoration(labelText: 'Rua / número / complemento'),
            ),
            TextFormField(
              controller: _bairroController,
              decoration: const InputDecoration(labelText: 'Bairro'),
            ),
            TextFormField(
              controller: _cidadeController,
              decoration: const InputDecoration(labelText: 'Cidade'),
            ),
            DropdownButtonFormField<String>(
              value: _estado,
              items: const [
                DropdownMenuItem(value: 'SP', child: Text('SP')),
                DropdownMenuItem(value: 'RJ', child: Text('RJ')),
                DropdownMenuItem(value: 'MG', child: Text('MG')),
                DropdownMenuItem(value: 'RS', child: Text('RS')),
                DropdownMenuItem(value: 'PR', child: Text('PR')),
                DropdownMenuItem(value: 'SC', child: Text('SC')),
                DropdownMenuItem(value: 'BA', child: Text('BA')),
                DropdownMenuItem(value: 'PE', child: Text('PE')),
                DropdownMenuItem(value: 'CE', child: Text('CE')),
                DropdownMenuItem(value: 'GO', child: Text('GO')),
                DropdownMenuItem(value: 'DF', child: Text('DF')),
                // ... outros estados
              ],
              onChanged: (v) => setState(() => _estado = v),
              decoration: const InputDecoration(labelText: 'Estado (UF)'),
            ),
            TextFormField(
              controller: _cepController,
              decoration: const InputDecoration(labelText: 'CEP'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            // TODO: Máscara e auto-preenchimento via API dos Correios
            const Divider(),
            const Text('Conta de Recebimento', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            DropdownButtonFormField<String>(
              value: _tipoPix,
              items: const [
                DropdownMenuItem(value: 'CPF', child: Text('CPF')),
                DropdownMenuItem(value: 'CNPJ', child: Text('CNPJ')),
                DropdownMenuItem(value: 'E-mail', child: Text('E-mail')),
                DropdownMenuItem(value: 'Telefone', child: Text('Telefone')),
                DropdownMenuItem(value: 'Aleatória', child: Text('Chave aleatória')),
              ],
              onChanged: (v) => setState(() => _tipoPix = v),
              decoration: const InputDecoration(labelText: 'Tipo de chave PIX'),
            ),
            TextFormField(
              controller: _chavePixController,
              decoration: const InputDecoration(labelText: 'Chave PIX'),
            ),
            DropdownButtonFormField<String>(
              value: _banco,
              items: const [
                DropdownMenuItem(value: 'Banco do Brasil', child: Text('Banco do Brasil')),
                DropdownMenuItem(value: 'Caixa', child: Text('Caixa')),
                DropdownMenuItem(value: 'Bradesco', child: Text('Bradesco')),
                DropdownMenuItem(value: 'Itaú', child: Text('Itaú')),
                DropdownMenuItem(value: 'Santander', child: Text('Santander')),
                DropdownMenuItem(value: 'Nubank', child: Text('Nubank')),
                DropdownMenuItem(value: 'Inter', child: Text('Inter')),
                DropdownMenuItem(value: 'Outros', child: Text('Outros')),
              ],
              onChanged: (v) => setState(() => _banco = v),
              decoration: const InputDecoration(labelText: 'Banco'),
            ),
            TextFormField(
              controller: _agenciaController,
              decoration: const InputDecoration(labelText: 'Agência'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _contaController,
              decoration: const InputDecoration(labelText: 'Conta bancária (com dígito)'),
              keyboardType: TextInputType.number,
            ),
            const Divider(),
            const Text('Tipos de atendimento oferecidos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            CheckboxListTile(
              value: _tiposAtendimento.contains('Tradicional'),
              onChanged: (v) => setState(() => v == true ? _tiposAtendimento.add('Tradicional') : _tiposAtendimento.remove('Tradicional')),
              title: const Text('Tradicional (no local)'),
            ),
            CheckboxListTile(
              value: _tiposAtendimento.contains('Domiciliar'),
              onChanged: (v) => setState(() => v == true ? _tiposAtendimento.add('Domiciliar') : _tiposAtendimento.remove('Domiciliar')),
              title: const Text('Domiciliar'),
            ),
            CheckboxListTile(
              value: _tiposAtendimento.contains('Humanizado'),
              onChanged: (v) => setState(() => v == true ? _tiposAtendimento.add('Humanizado') : _tiposAtendimento.remove('Humanizado')),
              title: const Text('Atendimento humanizado / acessível'),
            ),
            CheckboxListTile(
              value: _tiposAtendimento.contains('Noturno'),
              onChanged: (v) => setState(() => v == true ? _tiposAtendimento.add('Noturno') : _tiposAtendimento.remove('Noturno')),
              title: const Text('Atendimento noturno'),
            ),
            CheckboxListTile(
              value: _tiposAtendimento.contains('Exclusivo'),
              onChanged: (v) => setState(() => v == true ? _tiposAtendimento.add('Exclusivo') : _tiposAtendimento.remove('Exclusivo')),
              title: const Text('Atendimento por agendamento exclusivo'),
            ),
            const Divider(),
            Row(
              children: [
                Checkbox(
                  value: _aceitaTermos,
                  onChanged: (v) => setState(() => _aceitaTermos = v ?? false),
                ),
                const Expanded(
                  child: Text('Aceito os Termos de Uso e a Política de Privacidade.'),
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
              onPressed: () {
                setState(() => _erro = null);
                if (_formKey.currentState!.validate()) {
                  if (!_aceitaTermos) {
                    setState(() => _erro = 'Você deve aceitar os Termos de Uso e a Política de Privacidade.');
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cadastro realizado!')),
                  );
                  widget.onVoltar();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7043),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Continuar Cadastro'),
            ),
            TextButton(
              onPressed: widget.onVoltar,
              child: const Text('Voltar ao Login'),
            ),
          ],
        ),
      ),
    );
  }
}
