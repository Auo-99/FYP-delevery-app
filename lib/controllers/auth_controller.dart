import 'package:delevery_app/data/repository/auth_repo.dart';
import 'package:delevery_app/models/response_model.dart';
import 'package:get/get.dart';
import '../models/sign_up_model.dart';

class AuthController extends GetxController implements GetxService{
  AuthRepo authRepo;
  AuthController({
    required this.authRepo
});

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  Future<ResponseModel>registration(SignUpModel model)async{
    _isLoading = true;
    update();
    Response response = await authRepo.registration(model);
    late ResponseModel responseModel;

    //if statusCode = 200 the server will send a token
    //and we will save this token locally(sharedPreferences)
    if(response.statusCode==200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);

    }else{
      responseModel = ResponseModel(false, response.statusText.toString());
    }
    _isLoading =false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone, String password)async{
    _isLoading = true;
    update();
    Response response = await authRepo.login(phone , password);

    late ResponseModel responseModel;

    //if statusCode = 200 the server will send a token
    //and we will save this token locally(sharedPreferences)
    if(response.statusCode==200){

      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);

    }else{
      responseModel = ResponseModel(false, response.statusText.toString());
    }
    _isLoading =false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIn(){
    return authRepo.userLoggedIn();
  }

  bool clearSharedData(){
    return authRepo.clearSharedData();
  }

}