class CheckoutOrderRequest {
  String basketId = "";

  CheckoutOrderRequest(this.basketId);

  Map<String, dynamic> toBodyRequest() => {
        'basketId': basketId,
      };
}
