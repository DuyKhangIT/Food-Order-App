import 'data_response.dart';

class ProductResponse {
  bool? status = false;
  DataResponse? dataResponse;

  ProductResponse(
      this.status,
      this.dataResponse,
      );
  ProductResponse.buildDefault();
  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      json['status'],
        (json['data'] != null) ? DataResponse.fromJson(json['data']) : null,
    );
  }
}