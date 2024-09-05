class CheckoutOrderRequest {
  String orderId = "";


  CheckoutOrderRequest(this.orderId);

  Map<String, dynamic> toBodyRequest() => {
    'orderId': orderId,

  };
}
