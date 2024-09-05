class PostOrderResponse {
  bool status = false;

  PostOrderResponse(
    this.status,
  );

  PostOrderResponse.buildDefault();

  factory PostOrderResponse.fromJson(Map<String, dynamic> json) {
    return PostOrderResponse(
      json['status'],
    );
  }
}
