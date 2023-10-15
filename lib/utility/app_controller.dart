import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ielproject/models/data_model.dart';
import 'package:ielproject/models/token_model.dart';

class AppController extends GetConnect {
  RxBool redEye = true.obs;
  RxBool rememberMe = true.obs;

  RxList<TokenModel> tokenmodels = <TokenModel>[].obs;

  RxInt indexBody = 0.obs;
  RxList<DataModel> dataModels = <DataModel>[].obs;
  RxBool load = true.obs;
  RxList<Position> position = <Position>[].obs;
}
