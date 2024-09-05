import 'notification_object_response.dart';

class DataListNotificationResponse {
  String id = "";
  String username = "";

  List<NotificationObjectResponse>? listNotificationsResponse;

  DataListNotificationResponse(
    this.id,
    this.username,
    this.listNotificationsResponse,
  );

  factory DataListNotificationResponse.fromJson(Map<String, dynamic> json) {
    List<NotificationObjectResponse> notificationResponseList = [];
    if (json['notifications'] != null) {
      List<dynamic> arrData = json['notifications'];
      for (var i = 0; i < arrData.length; i++) {
        notificationResponseList.add(NotificationObjectResponse.fromJson(
            arrData[i] as Map<String, dynamic>));
      }
    }
    return DataListNotificationResponse(
      json["_id"],
      json["username"],
      notificationResponseList,
    );
  }
}
