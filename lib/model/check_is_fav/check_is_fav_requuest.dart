class CheckIsFavoriteRequest {
  String userId = "";
  String foodId = "";


  CheckIsFavoriteRequest(this.userId,this.foodId);

  Map<String, dynamic> toBodyRequest() => {
    'userId': userId,
    'foodId': foodId,

  };
}
