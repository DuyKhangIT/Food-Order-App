class AddOrRemoveFavoriteRequest {
  String userId = "";
  String foodId = "";


  AddOrRemoveFavoriteRequest(this.userId,this.foodId);

  Map<String, dynamic> toBodyRequest() => {
    'userId': userId,
    'foodId': foodId,

  };
}
