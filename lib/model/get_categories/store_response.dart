import 'data_categories_response.dart';

class StoreResponse {
  bool? status = false;
  DataCategoriesResponse? dataCategoriesResponse;

  StoreResponse(
    this.status,
    this.dataCategoriesResponse,
  );

  StoreResponse.buildDefault();

  factory StoreResponse.fromJson(Map<String, dynamic> json) {
    return StoreResponse(
      json['status'],
      (json['data'] != null)
          ? DataCategoriesResponse.fromJson(json['data'])
          : null,
    );
  }
}
