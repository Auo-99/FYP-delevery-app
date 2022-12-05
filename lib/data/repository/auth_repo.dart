import 'package:delevery_app/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/sign_up_model.dart';
import '../../utils/app_constants.dart';

class AuthRepo{
  ApiClient apiClient;
  //sharedPreferences => one we get token from server saved in out app inside
  SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences
});



  Future<Response> registration(SignUpModel model)async{
    //uri should be end point
    //body => send user data to the server (server receive jsonData)
    return await apiClient.postData(AppConstants.REGISTRATION_URI, model.toJson());
  }

  Future<Response> login(String phone, String password)async{
    //apiClient.postData => takes uri and body{email + password}
    //it's just 2field we don't need to create a model
    return await apiClient.postData(AppConstants.LOGIN_URI, {"phone":phone, "password":password});
  }

  Future<bool> saveUserToken(String token)async{
    //saving user token
    //update the header (method in apiClient)
    apiClient.token = token;
    apiClient.updateHeaders(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<String> getUserToken()async{
    return await sharedPreferences.getString(AppConstants.TOKEN)??"Null Token";
  }

  bool userLoggedIn(){
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<void> saveUserNumberAndPassword(String number, String password)async {
    try{
      await sharedPreferences.setString(AppConstants.NUMBER, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }

  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.NUMBER);
    apiClient.token="";
    apiClient.updateHeaders('');
    return true;
  }

}