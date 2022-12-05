import 'package:delevery_app/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../utils/app_constants.dart';

class UserRepo{
  ApiClient apiClient;
  UserRepo({
    required this.apiClient
});

  Future<Response> getUserInfo()async{
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }
}