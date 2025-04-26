import 'package:flutter/material.dart';
import 'package:projetointegrador2025/widgets/primary_button.dart';
import 'package:projetointegrador2025/widgets/app_header_bar.dart';
import 'package:projetointegrador2025/widgets/app_text_field.dart';
import 'package:projetointegrador2025/services/repositorio.dart';
import '../utils/index.dart';
import '../models/modelo_produto.dart';

class AdicionarProduto extends StatefulWidget {
  const AdicionarProduto({super.key});

  @override
  State<AdicionarProduto> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AdicionarProduto> {
  final _repo = Repository.instance;
  final _prodCtrl = TextEditingController();
  final _catCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  @override
  void dispose() {
    _prodCtrl.dispose();
    _catCtrl.dispose();
    _qtyCtrl.dispose();
    _priceCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final nome = _prodCtrl.text.trim();
    if (nome.isEmpty) return;

    final produto = Product(
      id: null,
      name: nome,
      category: _catCtrl.text.trim(),
      quantity: int.tryParse(_qtyCtrl.text.trim()) ?? 0,
      price: double.tryParse(_priceCtrl.text.trim()) ?? 0,
      desc: _descCtrl.text.trim(),
    );

    await _repo.addProduct(produto);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produto salvo com sucesso!')),
      );
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
              S.addProductTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.titleBrown,
              ),
            ),
          ),
          const SizedBox(height: 32),
          AppTextField(controller: _prodCtrl, label: 'produto'),
          AppTextField(controller: _catCtrl, label: 'categoria'),
          AppTextField(
            controller: _qtyCtrl,
            label: 'quantidade',
            keyboardType: TextInputType.number,
          ),
          AppTextField(
            controller: _priceCtrl,
            label: 'preço',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          AppTextField(controller: _descCtrl, label: 'descrição', maxLines: 2),
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
