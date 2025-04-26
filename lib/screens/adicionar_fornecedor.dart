import 'package:flutter/material.dart';
import 'package:projetointegrador2025/models/modelo_fornecedores.dart';
import 'package:projetointegrador2025/widgets/app_header_bar.dart';
import 'package:projetointegrador2025/widgets/app_text_field.dart';
import 'package:projetointegrador2025/widgets/primary_button.dart';
import 'package:projetointegrador2025/services/repositorio.dart';
import '../utils/index.dart';

class AdicionarFornecedor extends StatefulWidget {
  const AdicionarFornecedor({super.key});

  @override
  State<AdicionarFornecedor> createState() => _AdicionarFornecedorState();
}

class _AdicionarFornecedorState extends State<AdicionarFornecedor> {
  final _repo = Repository.instance;
  final _nameCtrl = TextEditingController();
  final _prodCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _prodCtrl.dispose();
    _qtyCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final nome = _nameCtrl.text.trim();
    if (nome.isEmpty) return;

    final supplier = Fornecedor(
      id: null,
      name: nome,
      product: _prodCtrl.text.trim(),
      quantity: int.tryParse(_qtyCtrl.text.trim()) ?? 0,
      desc: _descCtrl.text.trim(),
    );

    await _repo.addSupplier(supplier);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fornecedor salvo com sucesso!')),
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
              S.addSupplierTitle,
              style: const TextStyle(
                color: AppColors.titleBrown,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 32),
          AppTextField(controller: _nameCtrl, label: 'nome'),
          AppTextField(controller: _prodCtrl, label: 'produto fornecido'),
          AppTextField(
            controller: _qtyCtrl,
            label: 'quantidade',
            keyboardType: TextInputType.number,
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
