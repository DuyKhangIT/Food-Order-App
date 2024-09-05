import 'data_sum_order_response.dart';

class SumOrderResponse {
  bool status = false;
  DataSumOrderResponse? dataSumOrderResponse;
  SumOrderResponse(
    this.status,
    this.dataSumOrderResponse
  );

  SumOrderResponse.buildDefault();

  factory SumOrderResponse.fromJson(Map<String, dynamic> json) {
    return SumOrderResponse(
      json['status'],
      (json['data'] != null)
          ? DataSumOrderResponse.fromJson(json['data'])
          : null,
    );
  }
}
