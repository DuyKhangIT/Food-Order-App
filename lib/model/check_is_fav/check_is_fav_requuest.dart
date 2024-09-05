class CheckIsFavoriteRequest {
  String username = "";
  String foodId = "";


  CheckIsFavoriteRequest(this.username,this.foodId);

  Map<String, dynamic> toBodyRequest() => {
    'username': username,
    'foodId': foodId,

  };
}
