// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';

import 'package:ielproject/widgets/widget_text.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    required this.label,
    required this.pressFunc,
    this.gfButtonShape,
    this.gfButtonType,
  }) : super(key: key);

  final String label;
  final Function() pressFunc;
  final GFButtonShape? gfButtonShape;
  final GFButtonType? gfButtonType;

  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: pressFunc,
      text: label,
      shape: gfButtonShape ?? GFButtonShape.standard,
      type: gfButtonType ?? GFButtonType.solid,
      color: const Color.fromARGB(255, 238, 11, 87)
    );
  }
}
