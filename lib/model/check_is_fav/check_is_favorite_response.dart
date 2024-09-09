class CheckIsFavoriteResponse {
  bool isFavorite = false;
  CheckIsFavoriteResponse(this.isFavorite);

  CheckIsFavoriteResponse.buildDefault();

  factory CheckIsFavoriteResponse.fromJson(Map<String, dynamic> json) {
    return CheckIsFavoriteResponse(
      json['isFavorite'],
    );
  }
}
