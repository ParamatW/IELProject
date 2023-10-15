import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ielproject/models/data_model.dart';
import 'package:ielproject/models/token_model.dart';
import 'package:ielproject/states/main_home.dart';
import 'package:ielproject/utility/App_snackbar.dart';
import 'package:ielproject/utility/app_controller.dart';
import 'package:ielproject/utility/app_dialog.dart';
import 'package:ielproject/widgets/widget_button.dart';
import 'package:ielproject/widgets/widget_text.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> checkAuthen(
      {required String user, required String password}) async {
    String urlApi =
        'https://dev-api-ismart.interexpress.co.th/User/login/employee';

    Map<String, dynamic> map = {};
    map['UserName'] = user;
    map['Password'] = password;
    map['ApplicationId'] = 6;

    print('map >>>>  $map');

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';

    try {
      var response = await dio.post(urlApi, data: map);

      // print('token ----> ${response.data["token"]}');

      TokenModel tokenModel = TokenModel.fromMap(response.data["token"]);
      appController.tokenmodels.add(tokenModel);

      AppSnackBar(
              title: 'Authen Success',
              message: 'Welcome Employee ${tokenModel.employeeNo}')
          .normalSnackBar();

      if (appController.rememberMe.value) {
        Map<String, dynamic> data = {};
        data['user'] = user;
        data['password'] = password;
        await GetStorage().write('data', data).then((value) {
          Get.offAll(const MainHome());
        });
      } else {
        Get.offAll(const MainHome());
      }

      print('## tokenModel ----> ${tokenModel.toMap()}');
    } on Exception catch (e) {
      AppSnackBar(title: 'Login False', message: 'Please Try Afain')
          .errorSnackBar();
    }
    // print('statusCode ---> ${value.statusCode}');
  }

  Future<void> findTokenModel(
      {required String user, required String password}) async {
    String urlApi =
        'https://dev-api-ismart.interexpress.co.th/User/login/employee';

    Map<String, dynamic> map = {};
    map['UserName'] = user;
    map['Password'] = password;
    map['ApplicationId'] = 6;

    print('map >>>>  $map');

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';

    try {
      var response = await dio.post(urlApi, data: map);

      print('##### token ----> ${response.data["token"]}');

      TokenModel tokenModel = TokenModel.fromMap(response.data["token"]);

      print('##### TokenModel ${tokenModel.toMap()}');
      appController.tokenmodels.add(tokenModel);

      print('getx tokenModel ----> ${appController.tokenmodels.length}');
    } on Exception catch (e) {
      AppSnackBar(title: 'Login False', message: 'Please Try Afain')
          .errorSnackBar();
    }
    // print('statusCode ---> ${value.statusCode}');
  }

  Future<void> insertNewData({required Map<String, dynamic> map}) async {
    String urlApi =
        'https://dev-api-ismart.interexpress.co.th/Test/insert-data';

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Authorization'] =
        'Bearer ${appController.tokenmodels.last.accessToken}';

    try {
      var response = await dio.post(urlApi, data: map);
      Get.back();
      AppSnackBar(title: 'Add New Data Success', message: 'Thankyou')
          .normalSnackBar();
    } on Exception catch (e) {
      AppSnackBar(title: 'Cannot Add New Data', message: 'Please Try Again')
          .errorSnackBar();
    }
  }

  Future<void> processReadAllData() async {
    appController.load.value = true;

    String urlApi = 'https://dev-api-ismart.interexpress.co.th/Test/list-all';

    if (appController.tokenmodels.isEmpty) {
      var data = await GetStorage().read('data');
      print('### data = $data');
      findTokenModel(user: data['user'], password: data['password'])
          .then((value) async {
        print(
            '##### tokenmodel after findTokenModel ---> ${appController.tokenmodels.length}');

        if (appController.tokenmodels.isNotEmpty) {
          Dio dio = Dio();
          dio.options.headers['Content-Type'] = 'application/json';
          dio.options.headers['Authorization'] =
              'Bearer ${appController.tokenmodels.last.accessToken}';

          await dio.get(urlApi).then((value) {
            appController.load.value = false;
            var result = value.data;
            print('###14oct result+--> $result');

            if (appController.dataModels.isNotEmpty) {
              appController.dataModels.clear();
            }

            for (var element in result) {
              DataModel dataModel = DataModel.fromMap(element);

              appController.dataModels.add(dataModel);
            }
          }).catchError((onError) {
            appController.load.value = false;
            AppSnackBar(title: 'Token False', message: 'Please Login Again')
                .errorSnackBar();
            GetStorage().remove('data');
            Get.offAllNamed('/authen');
          });
        }
      });
    }
  }

  Future<void> processUpdateData({required Map<String, dynamic> map}) async {
    String urlApi =
        'https://dev-api-ismart.interexpress.co.th/Test/update-data';

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Authorization'] =
        'Bearer ${appController.tokenmodels.last.accessToken}';

    await dio.put(urlApi, data: map).then((value) {
      Get.back();
      AppSnackBar(title: 'Edit success', message: 'ThankTou').normalSnackBar();
    }).catchError((onError) {});
  }

  Future<void> processDeleteData({required int id}) async {
    String urlApi =
        'https://dev-api-ismart.interexpress.co.th/Test/delete-data';

    Map<String, dynamic> map = {};
    map['Id'] = id;

    print('##map --> $map');

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Authorization'] =
        'Bearer ${appController.tokenmodels.last.accessToken}';

    await dio
        .delete(urlApi, data: map)
        .then((value) => AppService().processReadAllData())
        .catchError((onError) {
      print('on error $onError');
    });
    //   Get.back();
    //   AppSnackBar(title: 'delete success', message: 'delete Data')
    //       .normalSnackBar();
    // }).catchError((onError) {});
  }

  Future<void> processFindPosition() async {
    bool locationService = await Geolocator.isLocationServiceEnabled();
    LocationPermission locationPermission;

    if (locationService) {
      // Open Location
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.deniedForever) {
        // ไม่อนุญาติ
        dialogpenPermision();
      } else {
        //Away, one, Denied
        if (locationPermission == LocationPermission.denied) {
          locationPermission = await Geolocator.requestPermission();

          if ((locationPermission != LocationPermission.always) &&
              (locationPermission != LocationPermission.whileInUse)) {
            dialogpenPermision();
          } else {
            Position position = await Geolocator.getCurrentPosition();
            appController.position.add(position);
          }
        } else {
          Position position = await Geolocator.getCurrentPosition();
          appController.position.add(position);
        }
      }
    } else {
      // Off Location
      AppDialog().normalDialog(
          title: 'Off Location',
          contentWidget: WidgetText(data: 'Please Open Location'),
          secondActionWidget: WidgetButton(
              label: 'Open Location',
              pressFunc: () async {
                await Geolocator.openLocationSettings();
                exit(0);
              }));
    }
  }

  Future<void> dialogpenPermision() async {
    AppDialog().normalDialog(
        title: 'Open Permision',
        secondActionWidget: WidgetButton(
            label: 'Open Permision',
            pressFunc: () {
              Geolocator.openAppSettings();
              exit(0);
            }));
  }
}
