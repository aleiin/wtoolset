import 'package:flutter/material.dart';

class CountriesField extends StatefulWidget {
  const CountriesField({Key? key}) : super(key: key);

  @override
  _CountriesFieldState createState() => _CountriesFieldState();
}

class _CountriesFieldState extends State<CountriesField> {
  final FocusNode _focusNode = FocusNode();

  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context).insert(_overlayEntry!);
      } else {
        _overlayEntry?.remove();
      }
    });
  }

  ///
  OverlayEntry _createOverlayEntry() {
    RenderObject? renderBox = context.findRenderObject();

    return OverlayEntry(builder: (context) {
      return Positioned(
        child: Material(
          elevation: 4.0,
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: const [
              ListTile(
                title: Text("Syria"),
              ),
              ListTile(
                title: Text("Syria"),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      decoration: const InputDecoration(labelText: 'Country'),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
