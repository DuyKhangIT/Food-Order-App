class CheckoutOrderResponse {
  String message = "";

  CheckoutOrderResponse(
    this.message,
  );

  CheckoutOrderResponse.buildDefault();

  factory CheckoutOrderResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutOrderResponse(
      json['message'],
    );
  }
}
