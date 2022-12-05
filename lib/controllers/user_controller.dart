import 'package:delevery_app/data/repository/user_repo.dart';
import 'package:delevery_app/models/user_model.dart';
import 'package:get/get.dart';

import '../models/response_model.dart';

class UserController extends GetxController implements GetxService{
  UserRepo userRepo;
  UserController({
    required this.userRepo
});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  Future<ResponseModel> getUserInfo()async{
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;

    if(response.statusCode==200){
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "Successfully");

    }else{
      responseModel = ResponseModel(false, response.statusText.toString());
      print("fucked up");
    }
    print("Done Loading ?");
    update();
    return responseModel;
  }

}