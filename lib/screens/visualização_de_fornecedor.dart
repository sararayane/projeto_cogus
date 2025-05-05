import 'package:flutter/material.dart';
import 'package:projetointegrador2025/widgets/primary_button.dart';
import 'package:projetointegrador2025/widgets/app_header_bar.dart';
import 'package:projetointegrador2025/services/repositorio.dart';
import 'package:projetointegrador2025/models/modelo_fornecedores.dart';
import '../utils/index.dart';

class VisualizacaodeFornecedor extends StatefulWidget {
  const VisualizacaodeFornecedor({super.key});

  @override
  State<VisualizacaodeFornecedor> createState() =>
      _VisualizacaodeFornecedorState();
}

class _VisualizacaodeFornecedorState extends State<VisualizacaodeFornecedor> {
  final _searchCtrl = TextEditingController();
  late Future<List<Fornecedor>> _future;

  @override
  void initState() {
    super.initState();
    _future = Repository.instance.fetchSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final double maxPanelWidth =
        width <= 600
            ? double
                .infinity // celular
            : width <= 960
            ? 520 // tablet
            : 700; // desktop

    return Scaffold(
      appBar: AppHeaderBar(onBack: () => Navigator.pop(context)),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxPanelWidth),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Text(
                  S.viewSupTitle,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleBrown,
                  ),
                ),
                const SizedBox(height: 24),
                _searchField('Fornecedor', _searchCtrl, _filter),
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
        ),
      ),
    );
  }

  Widget _buildList() => FutureBuilder<List<Fornecedor>>(
    future: _future,
    builder: (ctx, snap) {
      if (!snap.hasData) {
        return const Center(child: CircularProgressIndicator());
      }
      final all = snap.data!;
      final term = _searchCtrl.text.trim().toLowerCase();
      final filtered =
          term.isEmpty
              ? all
              : all.where((f) => f.name.toLowerCase().contains(term)).toList();
      if (filtered.isEmpty) {
        return const Center(child: Text('Nenhuma informação'));
      }

      return ListView.separated(
        itemCount: filtered.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, i) {
          final f = filtered[i];
          return ListTile(title: Text(f.name), subtitle: Text(f.product));
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
