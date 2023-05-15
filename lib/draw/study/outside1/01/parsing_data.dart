import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 韦斌 on 2021/11/25 23:11
/// 说明: 解析数据
class ParsingData extends StatefulWidget {
  const ParsingData({Key? key}) : super(key: key);

  @override
  _ParsingDataState createState() => _ParsingDataState();
}

class _ParsingDataState extends State<ParsingData> {
  int positionCurrent = -1;

  String resultMessage = "";

  final dataList = [
    {
      "tag": "layout",
      "padding": 12,
      "margin": 12,
      "backgroundColor": "#ff0000",
      "borderWidth": 1,
      "borderColor": "#f2f2f2",
      "borderRadius": 12,
      "children": [
        {
          "tag": "text",
          "color": "#333333",
          "size": 14,
          "weight": true,
          "text": "身份信息"
        },
        {"tag": "input", "title": "姓名"},
        {"tag": "input", "title": "身份证"},
        {"tag": "input", "title": "电话"},
        {
          "tag": "checkBox",
          "title": "性别",
          "list": ["男", "女"]
        },
        {"tag": "datePicker", "title": "时间"},
        {
          "tag": "option",
          "title": "职业",
          "options": ["商人", "法师", "弓箭手", "战士", "奶妈"]
        }
      ]
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  /// 处理数据
  Widget handleFirstData({
    required List<dynamic> value,
  }) {
    for (int i = 0; i < value.length; i++) {
      if (value[i]["tag"] == "layout") {
        return handleLayoutView(value: value[i]);
      }
    }

    return Container();
  }

  /// 处理二层数据
  List<Widget> handleSecondData({
    required List<dynamic> value,
  }) {
    final viewList = <Widget>[];

    for (int i = 0; i < value.length; i++) {
      if (value[i]["tag"] == "text") {
        viewList.add(handleTextView(text: value[i]["text"], value: value[i]));
      } else if (value[i]["tag"] == "input") {
        viewList.add(handleInputView(text: value[i]["title"]));
      } else if (value[i]["tag"] == "checkBox") {
        viewList.add(handleCheckBoxView(
          text: value[i]["title"],
          children: value[i]["list"],
        ));
      } else if (value[i]["tag"] == "datePicker") {
        viewList.add(entryItemView(
          text: value[i]["title"],
          onTap: handleDatePickerView,
        ));
      } else if (value[i]["tag"] == "option") {
        viewList.add(entryItemView(
          text: value[i]["title"],
          title: resultMessage,
          onTap: () {
            // handlePositionView(children: value[i]["options"]);
            showBottomSheet(children: value[i]["options"]);
          },
        ));
      }
    }

    if (viewList.isNotEmpty) {
      viewList.add(Container());
    }

    return viewList;
  }

  Widget handleLayoutView({
    dynamic value,
  }) {
    double margin =
        value?['margin'] != null ? double.parse(value["margin"].toString()) : 0;
    double padding = value?['padding'] != null
        ? double.parse(value["padding"].toString())
        : 0;
    double borderRadius = value?['borderRadius'] != null
        ? double.parse(value["borderRadius"].toString())
        : 0;
    double borderWidth = value?['borderWidth'] != null
        ? double.parse(value["borderWidth"].toString())
        : 0;

    final borderColor = handleColor(colors: value?["borderColor"]);

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor != null ? borderColor : Color(0xFF000000),
          width: borderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: handleSecondData(value: value?["children"]),
      ),
    );
  }

  /// 处理颜色
  Color? handleColor({
    String? colors,
  }) {
    final color = (colors ?? "").isNotEmpty
        ? Color(int.parse(colors!.replaceAll("#", "0xFF")))
        : null;

    return color;
  }

  /// 处理文字显示
  Widget handleTextView({
    String? text,
    dynamic value,
  }) {
    final fontSize =
        value?["size"] != null ? double.parse(value["size"].toString()) : null;

    return Text(
      text ?? "",
      style: TextStyle(
        color: handleColor(colors: value["color"]),
        fontSize: fontSize,
        fontWeight: value?["weight"] != null ? FontWeight.bold : null,
      ),
    );
  }

  /// 处理输入框
  Widget handleInputView({
    String? text,
  }) {
    return Row(
      children: [
        Text(text ?? ""),
        Expanded(
          child: TextField(),
        ),
      ],
    );
  }

  Widget handleCheckBoxView({
    String? text,
    List<dynamic>? children,
  }) {
    final viewList = children?.asMap().keys.map((index) {
      return Flexible(
        child: RadioListTile(
          title: Text(children[index]),
          value: children[index].toString(),
          groupValue: false,
          onChanged: (value) {},
        ),
      );
    }).toList();

    return Row(
      children: <Widget>[
        Text(text ?? ""),
        Flexible(
          child: Row(
            children: viewList != null ? viewList : [],
          ),
        ),
      ],
    );
  }

  void handleDatePickerView({
    String? text,
  }) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
  }

  void handlePositionView({
    List<dynamic>? children,
  }) {
    final listView = <Widget>[];

    children?.asMap().keys.map((index) {
      listView.add(
        GestureDetector(
          onTap: () {
            positionCurrent = index;
            setState(() {});
          },
          child: Container(
            height: 48,
            // color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(children[index]),
                if (positionCurrent == index) Icon(Icons.done),
              ],
            ),
          ),
        ),
      );
    }).toList();

    showDialog(
      context: context,
      barrierDismissible: true,
      useSafeArea: false,
      builder: (BuildContext context) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.close,
                          color: Colors.transparent,
                        ),
                        Text(
                          "职业",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Icon(Icons.close),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: listView,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget entryItemView({
    String? text,
    String? title,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        color: Colors.transparent,
        margin: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text ?? ""),
            Row(
              children: [
                Text(title ?? ""),
                Icon(Icons.chevron_right),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheet({
    List<dynamic>? children,
  }) {
    final listView = children?.asMap().keys.map((index) {
      return GestureDetector(
        onTap: () {
          positionCurrent = index;
          resultMessage = children[index];
          Navigator.of(context).pop();
          setState(() {});
        },
        child: Container(
          height: 48,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(children[index]),
              if (positionCurrent == index) Icon(Icons.done),
            ],
          ),
        ),
      );
    }).toList();

    showModalBottomSheet(
      context: context,
      enableDrag: false,
      builder: (BuildContext context) {
        return Container(
          // height: 310,
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: listView as List<Widget>,
              ),

              Container(
                color: Colors.grey[300],
                height: 8,
              ),

              //取消按钮
              //添加个点击事件
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  child: Text("取消"),
                  height: 44,
                  alignment: Alignment.center,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: handleFirstData(value: dataList),
    );
  }
}
