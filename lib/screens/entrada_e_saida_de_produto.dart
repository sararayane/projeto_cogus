import 'package:flutter/material.dart';
import 'package:projetointegrador2025/widgets/aumentar_diminuir.dart';
import 'package:projetointegrador2025/widgets/primary_button.dart';
import 'package:projetointegrador2025/widgets/app_header_bar.dart';
import 'package:projetointegrador2025/widgets/app_text_field.dart';
import 'package:projetointegrador2025/services/repositorio.dart';
import '../utils/index.dart';

class EntradaeSaidadeProduto extends StatefulWidget {
  const EntradaeSaidadeProduto({super.key});

  @override
  State<EntradaeSaidadeProduto> createState() => _EntradaeSaidadeProdutoState();
}

class _EntradaeSaidadeProdutoState extends State<EntradaeSaidadeProduto> {
  bool _entrada = true;
  int _qty = 1;
  final _prodCtrl = TextEditingController();

  @override
  void dispose() {
    _prodCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final text = _prodCtrl.text.trim();
    if (text.isEmpty) return;

    final repo = Repository.instance;
    final prods = await repo.fetchProducts();

    final matches =
        prods.where((p) => p.name.toLowerCase() == text.toLowerCase()).toList();

    if (matches.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Produto não encontrado')));
      return;
    }

    final prod = matches.first;
    final newQty = _entrada ? prod.quantity + _qty : prod.quantity - _qty;
    final updated = prod.copyWith(quantity: newQty < 0 ? 0 : newQty);

    await repo.addProduct(updated);

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Estoque atualizado!')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppHeaderBar(onBack: () => Navigator.pop(context)),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: ListView(
        children: [
          Center(
            child: Text(
              S.stockMovementTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.titleBrown,
              ),
            ),
          ),
          const SizedBox(height: 32),

          Row(
            children: [
              Checkbox(
                value: _entrada,
                activeColor: Colors.green,
                onChanged: (_) => setState(() => _entrada = true),
              ),
              const Text('ENTRADA'),
              const SizedBox(width: 16),
              Checkbox(
                value: !_entrada,
                activeColor: Colors.red,
                onChanged: (_) => setState(() => _entrada = false),
              ),
              const Text('SAÍDA'),
            ],
          ),
          const SizedBox(height: 16),

          AppTextField(controller: _prodCtrl, label: 'produto'),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Container(
                  height: Dimensoes.buttonH,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensoes.radiusXL / 2),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Text('$_qty'),
                ),
              ),
              const SizedBox(width: 16),
              AumentarDiminuir(
                onInc: () => setState(() => _qty++),
                onDec: () => setState(() => _qty = (_qty > 1 ? _qty - 1 : 1)),
              ),
            ],
          ),
          const SizedBox(height: 32),

          Center(
            child: SizedBox(
              width: 160,
              child: PrimaryButton(label: S.confirm, onTap: _save),
            ),
          ),
        ],
      ),
    ),
  );
}
