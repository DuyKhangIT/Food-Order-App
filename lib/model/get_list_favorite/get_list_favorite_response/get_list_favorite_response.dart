import 'data_list_favorite_response.dart';

class GetListFavoriteResponse {
  bool? status = false;
  DataListFavoriteResponse? dataListFavoriteResponse;

  GetListFavoriteResponse(
    this.status,
    this.dataListFavoriteResponse,
  );
  GetListFavoriteResponse.buildDefault();
  factory GetListFavoriteResponse.fromJson(Map<String, dynamic> json) {
    return GetListFavoriteResponse(
      json['status'],
      (json['data'] != null)
          ? DataListFavoriteResponse.fromJson(json['data'])
          : null,
    );
  }
}
