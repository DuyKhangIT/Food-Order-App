import '../get_products/foods_response.dart';

class BasketResponse {
  String message = "";
  List<FoodsResponse> basketList = [];

  BasketResponse(
    this.message,
    this.basketList,
  );
  BasketResponse.buildDefault();
  factory BasketResponse.fromJson(Map<String, dynamic> json) {
    List<FoodsResponse> foodsResponse = [];
    if (json['basket'] != null) {
      List<dynamic> arrData = json['basket'];
      for (var i = 0; i < arrData.length; i++) {
        foodsResponse
            .add(FoodsResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return BasketResponse(
      json['message'],
      foodsResponse,
    );
  }
}
