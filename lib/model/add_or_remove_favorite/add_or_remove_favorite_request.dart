class AddOrRemoveFavoriteRequest {
  String foodId = "";


  AddOrRemoveFavoriteRequest(this.foodId);

  Map<String, dynamic> toBodyRequest() => {
    'foodId': foodId,

  };
}
