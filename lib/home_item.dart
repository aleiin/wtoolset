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
    return Container(
      height: 52,
      margin: const EdgeInsets.only(
        left: 12,
        right: 12,
      ),
      child: InkWell(
        onTap: onCallBack,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(text),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
