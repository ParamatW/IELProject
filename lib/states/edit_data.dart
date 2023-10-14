// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'package:ielproject/models/data_model.dart';
import 'package:ielproject/utility/App_snackbar.dart';
import 'package:ielproject/utility/app_constant.dart';
import 'package:ielproject/utility/app_service.dart';
import 'package:ielproject/widgets/widget_button.dart';
import 'package:ielproject/widgets/widget_form.dart';
import 'package:ielproject/widgets/widget_text.dart';

class EditData extends StatefulWidget {
  const EditData({
    Key? key,
    required this.dataModel,
  }) : super(key: key);

  final DataModel dataModel;

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  String? empIdCard, empNo;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  bool change = false;

  @override
  void initState() {
    super.initState();

    empIdCard = widget.dataModel.employeeIDCard;
    empNo = widget.dataModel.employeeNo;

    namecontroller.text = widget.dataModel.employeeTitleName;
    emailcontroller.text = widget.dataModel.employeeEmail;
    phonecontroller.text = widget.dataModel.employeeMobileNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          data: 'Edit Data',
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
                    child: WidgetForm(
                      changeFunc: (p0) {
                        change = true;
                      },
                      textEditingController: namecontroller,
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
                    child: WidgetForm(
                      changeFunc: ((p0) {
                        change = true;
                      }),
                      textEditingController: emailcontroller,
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
                    child: WidgetForm(
                      changeFunc: (p0) {
                        change = true;
                      },
                      textEditingController: phonecontroller,
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
                      label: 'Edit Data',
                      pressFunc: () {
                        if (change) {
                          //Have change

                          Map<String, dynamic> map = {};
                          map['Id'] = widget.dataModel.id;
                          map['EmployeeNo'] = empNo;
                          map['EmployeeIDCard'] = empIdCard;
                          map['EmployeeTitleName'] = namecontroller.text;
                          map['EmployeeEmail'] = emailcontroller.text;
                          map['EmployeeMobileNo'] = phonecontroller.text;

                          

                          AppService().processUpdateData(map: map);
                          print('###140ct map data --> ${map}');
                        } else {
                          AppSnackBar(
                                  title: 'ไม่มีการเปลี่ยนแปลง',
                                  message: 'ต้องแก้ไขอะไรบ้าง ?')
                              .errorSnackBar();
                        }

                        // AppService().insertNewData(map: map);
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
