class RemoveItemOrderRequest {
  String orderId = "";
  int positionFood = 0;

  RemoveItemOrderRequest(this.orderId, this.positionFood);

  Map<String, dynamic> toBodyRequest() => {
    'orderId': orderId,
    'positionFood': positionFood,
  };
}
