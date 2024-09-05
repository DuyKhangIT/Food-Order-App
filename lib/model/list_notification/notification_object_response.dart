class NotificationObjectResponse {
  String? content = "";
  String? id = "";

  NotificationObjectResponse(
    this.content,
    this.id,
  );

  factory NotificationObjectResponse.fromJson(Map<String, dynamic> json) {
    return NotificationObjectResponse(
      json['content'],
      json['_id'],
    );
  }
}
