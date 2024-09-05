import 'favorite_foods_response.dart';

class FavoriteObjectResponse {
  String id = "";
  String username = "";
  List<FavoriteFoodsResponse>? favoriteFood;

  FavoriteObjectResponse(this.id, this.username, this.favoriteFood);

  factory FavoriteObjectResponse.fromJson(Map<String, dynamic> json) {
    List<FavoriteFoodsResponse> favoriteFoodsResponse = [];
    if (json['favoriteFood'] != null) {
      List<dynamic> arrData = json['favoriteFood'];
      for (var i = 0; i < arrData.length; i++) {
        favoriteFoodsResponse.add(
            FavoriteFoodsResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return FavoriteObjectResponse(
      json['_id'],
      json['username'],
      favoriteFoodsResponse,
    );
  }
}
