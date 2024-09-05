class AddFavoriteRequest {
  String username = "";
  String foodId = "";


  AddFavoriteRequest(this.username,this.foodId);

  Map<String, dynamic> toBodyRequest() => {
    'username': username,
    'foodId': foodId,

  };
}
