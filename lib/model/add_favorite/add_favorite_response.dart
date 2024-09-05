class AddFavoriteResponse {
  bool status = false;
  int del = 0;
  AddFavoriteResponse(this.status, this.del);

  AddFavoriteResponse.buildDefault();

  factory AddFavoriteResponse.fromJson(Map<String, dynamic> json) {
    return AddFavoriteResponse(
      json['status'],
      json['del'],
    );
  }
}
