class FoodsResponse {
  String? id = "";
  String? title = "";
  String? description = "";
  int? price = 0;
  String? image = "";
  FoodsResponse(
    this.id,
    this.title,
    this.description,
    this.price,
    this.image,
  );

  factory FoodsResponse.fromJson(Map<String, dynamic> json) {
    return FoodsResponse(
      json['_id'],
      json['title'],
      json['description'],
      json['price'],
      json['image'],
    );
  }
}
