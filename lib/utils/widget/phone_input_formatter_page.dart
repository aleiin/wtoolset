import 'package:flutter/material.dart';
import 'package:wtoolset/utils/util/phone_input_formatter_util.dart';
import 'package:wtoolset/widget/custom_widget.dart';

class PhoneTextInputFormatterPage extends StatefulWidget {
  const PhoneTextInputFormatterPage({Key? key}) : super(key: key);

  @override
  State<PhoneTextInputFormatterPage> createState() =>
      _PhoneTextInputFormatterPageState();
}

class _PhoneTextInputFormatterPageState
    extends State<PhoneTextInputFormatterPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      titleLabel: '电话号码输入框测试',
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
                PhoneTextInputFormatter(
                    // maxLength: 7,
                    // masks: ['## ### ####'],
                    // masks: ['(###) ### ####'],
                    // masks: [
                    //   '(###) ###-####', // 9
                    //   '#########', // 9
                    //   '##@#####---####', // 9
                    //   '##@###*****##---#####', // 9
                    //   '###--###', // 6
                    //   '###-####', // 7
                    //   '####-####', // 8
                    // ],
                    // masks: [
                    //   '#####',
                    //   '#####-##',
                    //   '#####-###',
                    //   '######-###',
                    //   '######-######',
                    // ],
                    ),
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
