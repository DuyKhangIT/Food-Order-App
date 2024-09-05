class DataSumOrderResponse {
  int? total = 0;

  DataSumOrderResponse(
    this.total,
  );

  DataSumOrderResponse.buildDefault();
  factory DataSumOrderResponse.fromJson(Map<String, dynamic> json) {
    return DataSumOrderResponse(
      json['total'],
    );
  }
}
