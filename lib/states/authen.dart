import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ielproject/utility/app_constant.dart';
import 'package:ielproject/utility/app_controller.dart';
import 'package:ielproject/widgets/widget_button.dart';
import 'package:ielproject/widgets/widget_form.dart';
import 'package:ielproject/widgets/widget_icon_button.dart';
import 'package:ielproject/widgets/widget_image_asset.dart';
import 'package:ielproject/widgets/widget_text.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(decoration: AppConstan().Radiobox(),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        displayLogoAppname(),
                        const SizedBox(
                          height: 16,
                        ),
                        const WidgetForm(
                          hint: 'username',
                          suffixWidget: Icon(Icons.person),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        passwordWidget(),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox( width: 250,
                            child: WidgetButton(
                          label: 'Login',
                          pressFunc: () {},
                          gfButtonShape: GFButtonShape.pills,
                          gfButtonType: GFButtonType.outline2x,
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Obx passwordWidget() {
    return Obx(() {
      return WidgetForm(
        hint: 'password',
        obscure: appController.redEye.value,
        suffixWidget: WidgetIconButton(
          iconData: appController.redEye.value
              ? Icons.remove_red_eye
              : Icons.remove_red_eye_outlined,
          pressFunc: () {
            print('click');
            appController.redEye.value = !appController.redEye.value;
          },
        ),
      );
    });
  }

  Row displayLogoAppname() {
    return Row(
      children: [
        const WidgetImageAsset(
          size: 64,
        ),
        const SizedBox(
          width: 16,
        ),
        WidgetText(
          data: AppConstan.appName,
          textStyle: AppConstan().h1Style(size: 32),
        )
      ],
    );
  }
}
