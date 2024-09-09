class CheckIsFavoriteRequest {
  String foodId = "";


  CheckIsFavoriteRequest(this.foodId);

  Map<String, dynamic> toBodyRequest() => {
    'foodId': foodId,

  };
}
