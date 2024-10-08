import 'foods_response.dart';

class ProductResponse {
  List<FoodsResponse>? listFoods;

  ProductResponse(
    this.listFoods,
  );
  ProductResponse.buildDefault();
  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    List<FoodsResponse> foodsResponse = [];
    if (json['foods'] != null) {
      List<dynamic> arrData = json['foods'];
      for (var i = 0; i < arrData.length; i++) {
        foodsResponse
            .add(FoodsResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return ProductResponse(foodsResponse);
  }
}
