import 'data_get_order_response.dart';

class GetOrderResponse{
  bool status = false;
  DataGetOrderResponse? dataGetOrderResponse;

  GetOrderResponse(
      this.status,
      this.dataGetOrderResponse
      );

  GetOrderResponse.buildDefault();

  factory GetOrderResponse.fromJson(Map<String, dynamic> json) {
    return GetOrderResponse(
      json['status'],
      (json['data'] != null)
          ? DataGetOrderResponse.fromJson(json['data'])
          : null,
    );
  }
}