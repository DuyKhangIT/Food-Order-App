class CategoriesResponse {
  String? id = "";
  String? title = "";
  String? image = "";
  CategoriesResponse(
    this.id,
    this.title,
    this.image,
  );

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      json['_id'],
      json['title'],
      json['image'],
    );
  }
}
