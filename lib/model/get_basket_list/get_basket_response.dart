import '../get_products/foods_response.dart';

class GetBasketResponse {
  String? basketId;
  List<FoodsResponse> basketList = [];

  GetBasketResponse(
    this.basketId,
    this.basketList,
  );

  GetBasketResponse.buildDefault();

  factory GetBasketResponse.fromJson(Map<String, dynamic> json) {
    List<FoodsResponse> foodsResponse = [];
    if (json['basket'] != null) {
      List<dynamic> arrData = json['basket'];
      for (var i = 0; i < arrData.length; i++) {
        foodsResponse
            .add(FoodsResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return GetBasketResponse(
      json['basketId'],
      foodsResponse,
    );
  }
}
