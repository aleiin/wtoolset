import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wtoolset/utils/util/integer_input_formatter_util.dart';
import 'package:wtoolset/utils/util/phone_input_formatter_util.dart';
import 'package:wtoolset/widget/custom_widget.dart';

class IntegerTextInputFormatterPage extends StatefulWidget {
  const IntegerTextInputFormatterPage({Key? key}) : super(key: key);

  @override
  State<IntegerTextInputFormatterPage> createState() =>
      _IntegerTextInputFormatterPageState();
}

class _IntegerTextInputFormatterPageState
    extends State<IntegerTextInputFormatterPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      titleLabel: '整数输入框测试',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              // padding: EdgeInsets.zero,
              // isTitle: false,
              // hintText: '測試',
              keyboardType: const TextInputType.numberWithOptions(
                  // decimal: true,
                  ),
              inputFormatters: [
                /// 限制只能为数字
                FilteringTextInputFormatter.digitsOnly,

                /// 格式化
                const IntegerTextInputFormatter(),
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
