import 'data_list_noti_response.dart';

class ListNotificationResponse {
  bool? status = false;
  DataListNotificationResponse? dataListNotificationResponse;

  ListNotificationResponse(
    this.status,
    this.dataListNotificationResponse,
  );
  ListNotificationResponse.buildDefault();
  factory ListNotificationResponse.fromJson(Map<String, dynamic> json) {
    return ListNotificationResponse(
      json['status'],
      (json['data'] != null)
          ? DataListNotificationResponse.fromJson(json['data'])
          : null,
    );
  }
}
