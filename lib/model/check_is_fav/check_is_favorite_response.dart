class CheckIsFavoriteResponse {
  bool status = false;
  int isFav = 0;
  CheckIsFavoriteResponse(this.status, this.isFav);

  CheckIsFavoriteResponse.buildDefault();

  factory CheckIsFavoriteResponse.fromJson(Map<String, dynamic> json) {
    return CheckIsFavoriteResponse(
      json['status'],
      json['isFav'],
    );
  }
}
