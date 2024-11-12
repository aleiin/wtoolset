import 'package:flutter/material.dart';
import 'package:wtoolset/home_item.dart';
import 'package:wtoolset/layout/flow/color_block_flow.dart';
import 'package:wtoolset/utils/route.dart';
import 'package:wtoolset/utils/widget/currency_text_input_formatter_page.dart';
import 'package:wtoolset/utils/widget/integer_input_formatter_page.dart';
import 'package:wtoolset/utils/widget/phone_input_formatter_page.dart';
import 'package:wtoolset/utils/widget/voice_recording_page.dart';

class UtilPage extends StatefulWidget {
  const UtilPage({Key? key}) : super(key: key);

  @override
  _UtilPageState createState() => _UtilPageState();
}

class _UtilPageState extends State<UtilPage> {
  final List<Map<String, Object>> viewList = <Map<String, Object>>[];

  @override
  void initState() {
    super.initState();
    viewList.addAll(<Map<String, Object>>[
      {
        "title": "小数点格式化",
        "onTap": () {
          const Navigator()
              .pushRoute(context, const CurrencyTextInputFormatterPage());
        },
      },
      {
        "title": "整数格式化",
        "onTap": () {
          const Navigator()
              .pushRoute(context, const IntegerTextInputFormatterPage());
        },
      },
      {
        "title": "电话号码格式化",
        "onTap": () {
          const Navigator()
              .pushRoute(context, const PhoneTextInputFormatterPage());
        },
      },
      {
        "title": "语音录制",
        "onTap": () {
          const Navigator().pushRoute(context, const VoiceRecordingPage());
        },
      },
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("工具类"),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: ListView.builder(
          itemCount: viewList.length,
          itemBuilder: (BuildContext context, int index) {
            return HomeItem(
              text: viewList[index]['title'] as String,
              onCallBack: viewList[index]['onTap'] as Function(),
            );
          },
        ),
      ),
    );
  }
}
