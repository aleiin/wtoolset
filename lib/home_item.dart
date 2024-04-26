import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({
    Key? key,
    this.text = '标题',
    this.onCallBack,
  }) : super(key: key);

  ///
  final String text;

  ///
  final VoidCallback? onCallBack;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCallBack,
      child: Container(
        margin: const EdgeInsets.only(
          left: 12,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(text),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
