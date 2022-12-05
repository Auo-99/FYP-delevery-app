import 'package:delevery_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeader;
  late SharedPreferences sharedPreferences;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = sharedPreferences.getString(AppConstants.TOKEN) ?? "";
    _mainHeader = {
      "Accept" : "application/json",
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      "Connection" : "Keep-Alive"
    };
  }

  void updateHeaders(String token){
    _mainHeader = {
      "Accept" : "application/json",
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      "Connection" : "Keep-Alive"
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      //send custom headers if null send the main headers
      Response response = await get(uri, headers: headers??_mainHeader);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async{
    //print(body.toString()); //PRINT USER DATA WHEN CREATE AN ACCOUNT
    try{
      Response response = await post(uri, body, headers: _mainHeader);
      print(response.toString());
      return response;
    }catch(e){
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
