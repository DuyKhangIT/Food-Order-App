class SumOrderRequest {
  String orderId = "";


  SumOrderRequest(this.orderId);

  Map<String, dynamic> toBodyRequest() => {
    'orderId': orderId,

  };
}
