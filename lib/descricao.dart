import 'package:flutter/material.dart';
import 'checkout.dart';

class TelaDescricao extends StatefulWidget {
  final bool isProduto; // true para produto, false para serviço
  final Map<String, dynamic> dados;
  const TelaDescricao({super.key, required this.isProduto, required this.dados});

  @override
  State<TelaDescricao> createState() => _TelaDescricaoState();
}

class _TelaDescricaoState extends State<TelaDescricao> {
  int quantidade = 1;
  DateTime? dataSelecionada;
  TimeOfDay? horarioSelecionado;
  bool atendimentoPersonalizado = false;

  void _abrirConfiguracoesPerfil() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Configurações do Perfil', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Editar perfil'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (data != null) {
      setState(() => dataSelecionada = data);
    }
  }

  Future<void> _selecionarHorario() async {
    final horario = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (horario != null) {
      setState(() => horarioSelecionado = horario);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dados = widget.dados;
    final isProduto = widget.isProduto;
    final categorias = dados['categorias'] as List<String>? ?? [];
    final imagem = dados['imagem'] as String? ?? '';
    final nome = dados['nome'] as String? ?? '';
    final preco = dados['preco'] as String? ?? '';
    final precoEntrega = dados['precoEntrega'] as String? ?? '';
    final empresa = dados['empresa'] as String? ?? '';
    final descricao = dados['descricao'] as String? ?? '';
    final relacionados = dados['relacionados'] as List<Map<String, dynamic>>? ?? [];
    final feedbacks = dados['feedbacks'] as List<Map<String, dynamic>>? ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2c3e50),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _abrirConfiguracoesPerfil,
          ),
        ],
        title: const Text('Detalhes', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Categorias
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categorias.map((cat) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFa8e7cf),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF2c3e50)),
              ),
              child: Text(cat, style: const TextStyle(color: Color(0xFF2c3e50), fontWeight: FontWeight.bold)),
            )).toList(),
          ),
          const SizedBox(height: 16),
          // Imagem
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(imagem, height: 220, fit: BoxFit.cover, width: double.infinity, errorBuilder: (c, e, s) => Container(height: 220, color: Colors.grey[200], child: const Icon(Icons.image, size: 80)),),
          ),
          const SizedBox(height: 16),
          // Nome e preço
          Text(nome, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(preco, style: const TextStyle(fontSize: 20, color: Color(0xFFFF7043), fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          // Preço entrega ou agendamento
          isProduto
              ? Text('Entrega: $precoEntrega', style: const TextStyle(fontSize: 16, color: Colors.black54))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _selecionarData,
                          icon: const Icon(Icons.calendar_today),
                          label: Text(dataSelecionada == null ? 'Escolher data' : '${dataSelecionada!.day}/${dataSelecionada!.month}/${dataSelecionada!.year}'),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFa8e7cf), foregroundColor: Colors.black),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: _selecionarHorario,
                          icon: const Icon(Icons.access_time),
                          label: Text(horarioSelecionado == null ? 'Escolher horário' : horarioSelecionado!.format(context)),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFa8e7cf), foregroundColor: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: atendimentoPersonalizado,
                          onChanged: (v) => setState(() => atendimentoPersonalizado = v ?? false),
                        ),
                        const Text('Atendimento personalizado'),
                      ],
                    ),
                  ],
                ),
          const SizedBox(height: 8),
          // Empresa
          Text('Empresa: $empresa', style: const TextStyle(fontSize: 16, color: Colors.black87)),
          const SizedBox(height: 8),
          // Quantidade (apenas produto)
          if (isProduto)
            Row(
              children: [
                const Text('Quantidade:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: quantidade > 1 ? () => setState(() => quantidade--) : null,
                ),
                Text('$quantidade', style: const TextStyle(fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => quantidade++),
                ),
              ],
            ),
          if (isProduto)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_cart_outlined),
                      label: const Text('Adicionar ao carrinho'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2c3e50),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 48),
                      ),
                      onPressed: () {
                        // Integração futura com backend/carrinho
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Adicionado ao carrinho!')),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('Comprar agora'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7043),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 48),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutPage(
                              imagem: imagem,
                              nome: nome,
                              empresa: empresa,
                              quantidade: quantidade,
                              preco: preco,
                              precoEntrega: precoEntrega,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          if (!isProduto)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_cart_outlined),
                      label: const Text('Adicionar ao carrinho'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2c3e50),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 48),
                      ),
                      onPressed: () {
                        // Integração futura com backend/carrinho
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Serviço adicionado ao carrinho!')),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('Agendar agora'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7043),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 48),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutPage(
                              imagem: imagem,
                              nome: nome,
                              empresa: empresa,
                              quantidade: 1,
                              preco: preco,
                              precoEntrega: '',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          // Descrição
          const Text('Descrição', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 4),
          Text(descricao, style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 16),
          // Produtos relacionados
          if (relacionados.isNotEmpty) ...[
            const Text('Produtos relacionados', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: relacionados.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, i) {
                  final rel = relacionados[i];
                  return Container(
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF2c3e50)),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(rel['imagem'] ?? '', height: 50, width: 80, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.image)),
                        ),
                        const SizedBox(height: 4),
                        Text(rel['nome'] ?? '', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
          // Feedbacks
          const Text('Feedbacks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          if (feedbacks.isEmpty)
            const Text('Nenhum feedback ainda.', style: TextStyle(color: Colors.grey)),
          ...feedbacks.map((fb) => Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(fb['foto'] ?? '')),
                  title: Text(fb['usuario'] ?? ''),
                  subtitle: Text(fb['comentario'] ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (i) => Icon(Icons.star, color: i < (fb['nota'] ?? 0) ? Colors.amber : Colors.grey, size: 18)),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
