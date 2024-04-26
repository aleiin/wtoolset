import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wtoolset/utils/util/currency_input_formatter_util.dart';
import 'package:wtoolset/widget/custom_widget.dart';

class CurrencyTextInputFormatterPage extends StatefulWidget {
  const CurrencyTextInputFormatterPage({Key? key}) : super(key: key);

  @override
  State<CurrencyTextInputFormatterPage> createState() =>
      _CurrencyTextInputFormatterPageState();
}

class _CurrencyTextInputFormatterPageState
    extends State<CurrencyTextInputFormatterPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      titleLabel: '小数点输入框测试',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              // padding: EdgeInsets.zero,
              // isTitle: false,
              // hintText: '測試',
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[0-9.]*')),
                CurrencyTextInputFormatter(),
              ],
              controller: controller,
              onChanged: (value) {
                // if (value.isEmpty) {
                //   return;
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
