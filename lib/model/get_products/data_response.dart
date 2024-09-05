import '../get_products/foods_response.dart';

class DataResponse {
  List<FoodsResponse>? listFoods;

  DataResponse(
    this.listFoods,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) {
    List<FoodsResponse> foodsResponse = [];
    if (json['foods'] != null) {
      List<dynamic> arrData = json['foods'];
      for (var i = 0; i < arrData.length; i++) {
        foodsResponse
            .add(FoodsResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return DataResponse(
      foodsResponse,
    );
  }
}
