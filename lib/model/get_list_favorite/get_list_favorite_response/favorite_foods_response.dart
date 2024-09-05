class FavoriteFoodsResponse {
  String? id = "";
  String? title = "";
  String? description = "";
  String? image = "";
  int? price = 0;

  FavoriteFoodsResponse(
    this.id,
    this.title,
    this.description,
    this.image,
    this.price,
  );

  factory FavoriteFoodsResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteFoodsResponse(
      json['_id'],
      json['title'],
      json['description'],
      json['image'],
      json['price'],
    );
  }
}
