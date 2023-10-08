import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielproject/states/add_new_data.dart';
import 'package:ielproject/utility/app_constant.dart';
import 'package:ielproject/widgets/widget_text.dart';

class ListData extends StatelessWidget {
  const ListData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WidgetText(
            data: 'This is Data',
            textStyle: AppConstan().h2Style(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddNewData());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}



// , textStyle: AppConstan().h2Style(),