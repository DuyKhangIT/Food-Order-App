import 'favorite_object_response.dart';

class DataListFavoriteResponse {
  FavoriteObjectResponse? favoriteObjectResponse;

  DataListFavoriteResponse(
    this.favoriteObjectResponse,
  );

  factory DataListFavoriteResponse.fromJson(Map<String, dynamic> json) {
    return DataListFavoriteResponse(
      (json['favorite'] != null)
          ? FavoriteObjectResponse.fromJson(json['favorite'])
          : null,
    );
  }
}
