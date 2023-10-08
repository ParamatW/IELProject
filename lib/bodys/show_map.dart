import 'package:flutter/material.dart';
import 'package:ielproject/widgets/widget_text.dart';
import 'package:ielproject/utility/app_constant.dart';

class ShowMap extends StatelessWidget {
  const ShowMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WidgetText(data: 'This is ShowMap', textStyle: AppConstan().h2Style(),),
      ],
    );
  }
}