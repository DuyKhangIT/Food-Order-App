class PostOrderRequest {
  String userName = "";
  String? orderId = "";
  String addFoodId = "";

  PostOrderRequest(this.userName, this.orderId, this.addFoodId);

  Map<String, dynamic> toBodyRequest() => {
        'username': userName,
        'orderId': orderId,
        'addFood': addFoodId,
      };
}
