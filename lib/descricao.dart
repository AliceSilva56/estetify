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
  bool descricaoExpandida = false;

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

    // Para truncar descrição
    final descricaoMaxLines = descricaoExpandida ? null : 4;
    final descricaoOverflow = descricaoExpandida ? TextOverflow.visible : TextOverflow.ellipsis;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7043), // Laranja
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
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
                
              child: Text(cat, style: const TextStyle(color: Color(0xFF2c3e50), fontWeight: FontWeight.bold, fontSize: 10)),
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
              : const SizedBox.shrink(), // Remove seleção de data/horário e checkbox
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
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFFFF7043)),
                      label: const Text('Adicionar ao carrinho', style: TextStyle(color: Color(0xFFFF7043))),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFFFF7043), width: 2),
                        minimumSize: const Size(0, 48),
                        foregroundColor: Color(0xFFFF7043),
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
                      child: const Text('Comprar agora'),
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
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFFFF7043)),
                      label: const Text('Adicionar ao carrinho', style: TextStyle(color: Color(0xFFFF7043))),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                        side: const BorderSide(color: Color(0xFFFF7043), width: 2),
                        minimumSize: const Size(0, 48),
                        foregroundColor: Color(0xFFFF7043),
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
                      child: const Text('Agendar agora'),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          // Descrição
          const Text('Descrição', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 4),
          LayoutBuilder(
            builder: (context, constraints) {
              final span = TextSpan(text: descricao, style: const TextStyle(fontSize: 17));
              final tp = TextPainter(
                text: span,
                maxLines: 4,
                textDirection: TextDirection.ltr,
              )..layout(maxWidth: constraints.maxWidth);
              final isOverflow = tp.didExceedMaxLines;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    descricao,
                    style: const TextStyle(fontSize: 17),
                    maxLines: descricaoMaxLines,
                    overflow: descricaoOverflow,
                  ),
                  if (isOverflow || descricaoExpandida)
                    TextButton(
                      onPressed: () => setState(() => descricaoExpandida = !descricaoExpandida),
                      child: Text(descricaoExpandida ? 'Ver menos' : 'Ver mais', style: const TextStyle(color: Color(0xFFFF7043))),
                    ),
                ],
              );
            },
          ),
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
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFFFF7043), width: 1.5),
                ),
                elevation: 0,
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
