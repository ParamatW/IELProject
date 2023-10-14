import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ielproject/states/add_new_data.dart';
import 'package:ielproject/states/edit_data.dart';
import 'package:ielproject/utility/app_constant.dart';
import 'package:ielproject/utility/app_controller.dart';
import 'package:ielproject/utility/app_dialog.dart';
import 'package:ielproject/utility/app_service.dart';
import 'package:ielproject/widgets/widget_button.dart';
import 'package:ielproject/widgets/widget_process.dart';
import 'package:ielproject/widgets/widget_text.dart';

class ListData extends StatefulWidget {
  const ListData({super.key});

  @override
  State<ListData> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  ScrollController scrollController = ScrollController();

  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    AppService().processReadAllData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.minScrollExtent) {
        print('##onTop##');
        AppService().processReadAllData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: GetX(builder: (AppController appController) {
      //   print(
      //       '###15oct ขนาดของ dataModels ---> ${appController.dataModels.length}');
      //   return appController.dataModels.isEmpty
      //       ? const SizedBox()
      //       : WidgetText(
      //           data: 'This is Data',
      //           textStyle: AppConstan().h2Style(),
      //         );
      // }),
      body: Obx(() {
        print(
            '###15oct ขนาดของ dataModels ---> ${appController.dataModels.length}');
        return appController.load.value
            ? const WidgetProcess()
            : appController.dataModels.isEmpty
                ? const SizedBox()
                : ListView.builder(
                    controller: scrollController,
                    itemCount: appController.dataModels.length,
                    itemBuilder: (context, index) => Slidable(
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          extentRatio: 0.5,
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                AppDialog().normalDialog(
                                    title: 'confirm Delete',
                                    actionWidget: WidgetButton(
                                        label: 'Confirm',
                                        pressFunc: () {
                                          Get.back();
                                          AppService().processDeleteData(
                                              id: appController
                                                  .dataModels[index].id);
                                        }));
                              },
                              icon: Icons.delete_forever,
                              label: 'Delece',
                              backgroundColor: Colors.red.shade700,
                              foregroundColor: Colors.white,
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                Get.to(EditData(
                                        dataModel:
                                            appController.dataModels[index]))
                                    ?.then((value) =>
                                        AppService().processReadAllData());
                              },
                              icon: Icons.delete_forever,
                              label: 'Edit',
                              backgroundColor: Colors.blue.shade700,
                              foregroundColor: Colors.white,
                            )
                          ]),
                      child: SizedBox(
                        width: double.infinity,
                        child: InkWell(
                          onTap: () {
                            AppDialog().normalDialog(
                                title:
                                    appController.dataModels[index].employeeNo,
                                actionWidget: WidgetButton(
                                    label: 'Edit',
                                    pressFunc: () {
                                      Get.back();
                                      Get.to(EditData(
                                              dataModel: appController
                                                  .dataModels[index]))
                                          ?.then((value) => AppService()
                                              .processReadAllData());
                                    }),
                                contentWidget: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    displayValue(
                                        head: 'EmployeeNo',
                                        value: appController
                                            .dataModels[index].employeeNo),
                                    displayValue(
                                        head: 'EmpIdCard',
                                        value: appController
                                            .dataModels[index].employeeIDCard),
                                    displayValue(
                                        head: 'employeeMobileNo',
                                        value: appController.dataModels[index]
                                            .employeeMobileNo),
                                    displayValue(
                                        head: 'employeeTitleName',
                                        value: appController.dataModels[index]
                                            .employeeTitleName),
                                  ],
                                ));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 4),
                            child: Card(
                              color: index % 2 == 0
                                  ? Colors.white
                                  : Color.fromARGB(255, 245, 6, 85),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    displayValue(
                                      head: 'employeeTitleName',
                                      value: appController
                                          .dataModels[index].employeeTitleName,
                                    ),
                                    displayValue(
                                      head: 'EmployeeNo',
                                      value: appController
                                          .dataModels[index].employeeNo,
                                    ),
                                    displayValue(
                                        head: 'employeeIDCard',
                                        value: appController
                                            .dataModels[index].employeeIDCard),
                                    displayValue(
                                        head: 'employeeMobileNo',
                                        value: appController.dataModels[index]
                                            .employeeMobileNo),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddNewData())?.then((value) {
            AppService().processReadAllData();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  WidgetText displayValue({required String head, required String value}) {
    return WidgetText(data: '$head => $value');
  }
}



// , textStyle: AppConstan().h2Style(),