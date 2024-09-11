class BasketRequest {
  String foodId = "";

  BasketRequest(this.foodId);

  Map<String, dynamic> toBodyRequest() => {
        'foodId': foodId,
      };
}
