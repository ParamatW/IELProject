import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ielproject/states/authen.dart';
import 'package:ielproject/states/main_home.dart';
import 'package:ielproject/utility/app_service.dart';

var getPages = <GetPage<dynamic>>[
  GetPage(
    name: '/authen',
    page: () => const Authen(),
  ),
  GetPage(
    name: '/mainHome',
    page: () => const MainHome(),
  )
];

String? firstPage;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverride();
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init().then((value) async {
    var data = await GetStorage().read('data');
    print('data --> $data');

    if (data == null) {
      firstPage = '/authen';
      runApp(MyApp());
    } else {
      firstPage = '/mainHome';
      runApp(MyApp());

      await AppService()
          .findTokenModel(user: data['user'], password: data['password']);

      
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // home: Authen(),
      debugShowCheckedModeBanner: false,
      getPages: getPages,
      initialRoute: firstPage,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 245, 6, 85),
            foregroundColor: Colors.white,
            elevation: 0),
        scaffoldBackgroundColor: Color.fromARGB(255, 245, 149, 181),
      ),
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
