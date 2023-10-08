import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ielproject/utility/app_constant.dart';
import 'package:ielproject/utility/app_service.dart';
import 'package:ielproject/widgets/widget_button.dart';
import 'package:ielproject/widgets/widget_form.dart';
import 'package:ielproject/widgets/widget_text.dart';

class AddNewData extends StatefulWidget {
  const AddNewData({super.key});

  @override
  State<AddNewData> createState() => _AddNewDataState();
}

class _AddNewDataState extends State<AddNewData> {

  String? empIdCard, empNo;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();

    empIdCard = 'id-${Random().nextInt(100000)}';
    empNo = 'no-${Random().nextInt(100000)}';
    
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          data: 'Add New Data',
          textStyle: AppConstan().h2Style(),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 250,
                      margin: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WidgetText(data: 'EmployeeNo :'),
                          WidgetText(
                            data: empNo ?? '',
                            textStyle: AppConstan().h2Style(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 250,
                      margin: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WidgetText(data: 'EmployeeIDCard :'),
                          WidgetText(
                            data: empIdCard ?? '',
                            textStyle: AppConstan().h2Style(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 250,
                    margin: const EdgeInsets.only(top: 16),
                    child: WidgetForm(textEditingController: namecontroller,
                      labelWidget: const WidgetText(data: 'Name'),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 250,
                    margin: const EdgeInsets.only(top: 16),
                    child: WidgetForm(textEditingController: emailcontroller,
                      labelWidget: const WidgetText(data: 'Email'),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 250,
                    margin: const EdgeInsets.only(top: 16),
                    child: WidgetForm(textEditingController: phonecontroller,
                      labelWidget: const WidgetText(data: 'Phone Number'),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 250,
                    margin: const EdgeInsets.only(top: 16),
                    child: WidgetButton(
                      label: 'Add New Data',
                      pressFunc: () {
                        
                        Map<String, dynamic> map = {};
                        map['EmployeeNo'] = empNo;
                        map['EmployeeIDCard'] = empIdCard;
                        map['EmployeeTitleName'] = namecontroller.text;
                        map['EmployeeEmail'] = emailcontroller.text;
                        map['EmployeeMobileNo'] = phonecontroller.text;

                        AppService().insertNewData(map: map);


                      },
                      gfButtonShape: GFButtonShape.pills,
                      // gfButtonType: GFButtonType.outline2x,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
