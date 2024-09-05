class OrderDetailResponseGet {
  String? id = "";
  String? title = "";
  String? description = "";
  String? image = "";
  int? price = 0;

  OrderDetailResponseGet(
    this.id,
    this.title,
    this.description,
    this.image,
    this.price,
  );

  factory OrderDetailResponseGet.fromJson(Map<String, dynamic> json) {
    return OrderDetailResponseGet(
      json['_id'],
      json['title'],
      json['description'],
      json['image'],
      json['price'],
    );
  }
}
