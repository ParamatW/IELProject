import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ielproject/widgets/widget_button.dart';
import 'package:ielproject/widgets/widget_image_asset.dart';
import 'package:ielproject/widgets/widget_text.dart';

class AppDialog {
  void normalDialog({
    required String title,
    String? pahtImage,
    Widget? contentWidget,
    Widget? actionWidget,
    // Widget? secondActionWidget,
  }) {
    Get.dialog(
      AlertDialog(
        scrollable: true,
        icon: WidgetImageAsset(
          size: 150,
          path: pahtImage,
        ),
        title: WidgetText(data: title),
        content: contentWidget,
        actions: [
          actionWidget ?? const SizedBox(),
          actionWidget == null
              ? WidgetButton(
                  gfButtonType: GFButtonType.transparent,
                  label: 'OK',
                  pressFunc: () {
                    Get.back();
                  },
                )
              : WidgetButton(
                  gfButtonType: GFButtonType.outline,
                  label: 'Cancel',
                  pressFunc: () {
                    print('click cancel');
                    Get.back();
                  }),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
