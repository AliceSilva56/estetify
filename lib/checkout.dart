import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  final String imagem;
  final String nome;
  final String empresa;
  final int quantidade;
  final String preco;
  final String precoEntrega;

  const CheckoutPage({
    super.key,
    required this.imagem,
    required this.nome,
    required this.empresa,
    required this.quantidade,
    required this.preco,
    required this.precoEntrega,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2c3e50),
        title: const Text('Checkout', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(imagem, height: 60, width: 60, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.image)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nome, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('Empresa: $empresa', style: const TextStyle(fontSize: 14)),
                      Text('Quantidade: $quantidade', style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Preço: $preco', style: const TextStyle(fontSize: 16)),
            Text('Entrega: $precoEntrega', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Divider(),
            const Text('Endereço de entrega', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Rua, número, complemento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Bairro',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Cidade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                labelText: 'CEP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const Text('Pagamento', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: 'pix', child: Text('PIX')),
                DropdownMenuItem(value: 'cartao', child: Text('Cartão de crédito')),
                DropdownMenuItem(value: 'boleto', child: Text('Boleto')),
              ],
              onChanged: (v) {},
              decoration: const InputDecoration(labelText: 'Forma de pagamento'),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2c3e50),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 48),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Compra realizada com sucesso!')),
                  );
                },
                child: const Text('Finalizar compra'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
