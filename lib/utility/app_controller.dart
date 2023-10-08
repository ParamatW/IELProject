import 'package:get/get.dart';
import 'package:ielproject/models/token_model.dart';

class AppController extends GetConnect {

  RxBool redEye = true.obs;
  RxBool rememberMe = true.obs;

  RxList<TokenModel> tokenmodels = <TokenModel>[].obs;

  RxInt indexBody = 0.obs;
  
}