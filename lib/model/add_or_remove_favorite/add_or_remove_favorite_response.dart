class AddOrRemoveFavoriteResponse {
  bool status = false;
  String message = "";
  AddOrRemoveFavoriteResponse(this.status, this.message);

  AddOrRemoveFavoriteResponse.buildDefault();

  factory AddOrRemoveFavoriteResponse.fromJson(Map<String, dynamic> json) {
    return AddOrRemoveFavoriteResponse(
      json['status'],
      json['message'],
    );
  }
}
