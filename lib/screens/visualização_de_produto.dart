import 'package:flutter/material.dart';
import 'package:projetointegrador2025/widgets/primary_button.dart';
import 'package:projetointegrador2025/widgets/app_header_bar.dart';
import 'package:projetointegrador2025/services/repositorio.dart';
import 'package:projetointegrador2025/models/modelo_produto.dart';
import '../utils/index.dart';

class VisualizacaodeProduto extends StatefulWidget {
  const VisualizacaodeProduto({super.key});

  @override
  State<VisualizacaodeProduto> createState() => _VisualizacaodeProdutoState();
}

class _VisualizacaodeProdutoState extends State<VisualizacaodeProduto> {
  final _searchCtrl = TextEditingController();
  late Future<List<Product>> _future;

  @override
  void initState() {
    super.initState();
    _future = Repository.instance.fetchProducts();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppHeaderBar(onBack: () => Navigator.pop(context)),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            S.viewStockTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.titleBrown,
            ),
          ),
          const SizedBox(height: 24),

          _searchField('Produto', _searchCtrl, _filter),
          const SizedBox(height: 24),

          Expanded(child: _buildList()),
          const SizedBox(height: 16),

          SizedBox(
            width: 160,
            child: PrimaryButton(
              label: 'VISTO',
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildList() => FutureBuilder<List<Product>>(
    future: _future,
    builder: (ctx, snap) {
      if (!snap.hasData)
        return const Center(child: CircularProgressIndicator());
      final all = snap.data!;
      final term = _searchCtrl.text.trim().toLowerCase();
      final filtered =
          term.isEmpty
              ? all
              : all.where((p) => p.name.toLowerCase().contains(term)).toList();
      if (filtered.isEmpty)
        return const Center(child: Text('Nenhuma informação'));

      return ListView.separated(
        itemCount: filtered.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, i) {
          final p = filtered[i];
          return ListTile(
            title: Text(p.name),
            subtitle: Text('${p.quantity} un • ${p.category}'),
            trailing: Text('R\$ ${p.price.toStringAsFixed(2)}'),
          );
        },
      );
    },
  );

  void _filter() => setState(() {});

  Widget _searchField(
    String label,
    TextEditingController ctrl,
    VoidCallback onSearch,
  ) => TextField(
    controller: ctrl,
    decoration: InputDecoration(
      labelText: label,
      suffixIcon: IconButton(
        icon: const Icon(Icons.search),
        onPressed: onSearch,
      ),
    ),
    onSubmitted: (_) => onSearch(),
  );
}
