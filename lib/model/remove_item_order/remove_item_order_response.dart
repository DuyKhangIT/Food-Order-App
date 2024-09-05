class RemoveItemOrderResponse {
  bool status = false;

  RemoveItemOrderResponse(
      this.status,
      );

  RemoveItemOrderResponse.buildDefault();

  factory RemoveItemOrderResponse.fromJson(Map<String, dynamic> json) {
    return RemoveItemOrderResponse(
      json['status'],
    );
  }
}