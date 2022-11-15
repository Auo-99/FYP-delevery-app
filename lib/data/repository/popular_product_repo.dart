import 'package:delevery_app/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCTS_URI);
  }
}
//http://localhost:8000/api/v1/products/popular
