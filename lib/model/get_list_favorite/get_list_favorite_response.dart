import '../get_products/foods_response.dart';

class GetListFavoriteResponse {
  List<FoodsResponse>? favoriteFoods;

  GetListFavoriteResponse(
    this.favoriteFoods,
  );
  GetListFavoriteResponse.buildDefault();
  factory GetListFavoriteResponse.fromJson(Map<String, dynamic> json) {
    List<FoodsResponse> favoriteFoodsResponse = [];
    if (json['favorites'] != null) {
      List<dynamic> arrData = json['favorites'];
      for (var i = 0; i < arrData.length; i++) {
        favoriteFoodsResponse
            .add(FoodsResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return GetListFavoriteResponse(
      favoriteFoodsResponse,
    );
  }
}
