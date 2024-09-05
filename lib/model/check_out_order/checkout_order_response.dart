class CheckoutOrderResponse {
  bool status = false;

  CheckoutOrderResponse(
    this.status,
  );

  CheckoutOrderResponse.buildDefault();

  factory CheckoutOrderResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutOrderResponse(
      json['status'],
    );
  }
}
