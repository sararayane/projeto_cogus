import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _repo = Repository.instance;
  final _forCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController(text: '1');

  static const _products = [
    'Shiitake',
    'Shimeji Branco',
    'Shimeji Preto',
    'Paris',
    'Portobello',
    'Eryngui',
    'Salmão',
    'Shimofuri',
    'Enoki',
    'Hiratake',
    'Juba',
    'Nameko / Kikurage',
  ];

  String? _selectedProduct;
  bool _entrada = true;
  int _qty = 1;

  @override
  void dispose() {
    _forCtrl.dispose();
    _qtyCtrl.dispose();
    super.dispose();
  }

  void _setQty(int value) {
    _qty = value.clamp(1, 99999);
    _qtyCtrl.text = '$_qty';
    setState(() {});
  }

  void _onQtyChanged(String v) {
    final n = int.tryParse(v);
    if (n != null) {
      _qty = n.clamp(1, 99999);
      setState(() {});
    }
  }

  Future<void> _save() async {
    final fornecedor = _forCtrl.text.trim();
    if (fornecedor.isEmpty || _selectedProduct == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe fornecedor e selecione produto')),
      );
      return;
    }

    final prods = await _repo.fetchProducts();
    final match =
        prods
            .where(
              (p) => p.name.toLowerCase() == _selectedProduct!.toLowerCase(),
            )
            .toList();
    if (match.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Produto não cadastrado')));
      return;
    }

    final prod = match.first;
    final newQty = _entrada ? prod.quantity + _qty : prod.quantity - _qty;
    await _repo.addProduct(prod.copyWith(quantity: newQty < 0 ? 0 : newQty));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Estoque atualizado! Fornecedor: $fornecedor')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final double maxFormWidth =
        width <= 600
            ? double
                .infinity // celular
            : width <= 960
            ? 520 // tablet
            : 700; // desktop
    final double hPadding = width <= 600 ? 24 : 40;

    return Scaffold(
      appBar: AppHeaderBar(onBack: () => Navigator.pop(context)),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: hPadding),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxFormWidth),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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

                  AppTextField(controller: _forCtrl, label: 'fornecedor'),
                  const SizedBox(height: 24),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'produto'),
                    items:
                        _products
                            .map(
                              (p) => DropdownMenuItem(value: p, child: Text(p)),
                            )
                            .toList(),
                    value: _selectedProduct,
                    onChanged: (v) => setState(() => _selectedProduct = v),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Quantidade',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.titleBrown,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(
                        width: 90,
                        child: TextField(
                          controller: _qtyCtrl,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: _onQtyChanged,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(5),
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      AumentarDiminuir(
                        onInc: () => _setQty(_qty + 1),
                        onDec: () => _setQty(_qty - 1),
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
          ),
        ),
      ),
    );
  }
}
