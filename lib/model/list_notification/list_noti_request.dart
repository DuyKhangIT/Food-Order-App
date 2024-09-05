class ListNotificationRequest {
  String username = "";

  ListNotificationRequest(this.username);

  Map<String, dynamic> toBodyRequest() => {
        'username': username,
      };
}
