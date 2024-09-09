class PostOrderRequest {
  String? orderId = "";
  String addFoodId = "";

  PostOrderRequest(this.orderId, this.addFoodId);

  Map<String, dynamic> toBodyRequest() => {
        'orderId': orderId,
        'addFood': addFoodId,
      };
}
