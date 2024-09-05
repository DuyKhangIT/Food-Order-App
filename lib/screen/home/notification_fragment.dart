import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../handle_api/handle_api.dart';
import '../../model/list_notification/list_noti_request.dart';
import '../../model/list_notification/list_noti_response.dart';
import '../../model/list_notification/notification_object_response.dart';
import '../../util/share_preferences.dart';
import '../../util/show_loading_dialog.dart';

class NotificationDetail extends StatefulWidget {
  const NotificationDetail({Key? key}) : super(key: key);

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  String username = "";
  List<NotificationObjectResponse>? listNotification;
  bool isLoading = false;

  Future<void> getUserName() async {
    username = await ConfigSharedPreferences()
        .getStringValue(SharedData.USERNAME.toString(), defaultValue: "");
    setState(() {
      if (username.isNotEmpty || username != "") {
        ListNotificationRequest listNotificationRequest =
            ListNotificationRequest(username);
        getListNotification(listNotificationRequest);
      }
    });
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  /// call api list notification
  Future<ListNotificationResponse> getListNotification(
      ListNotificationRequest listNotificationRequest) async {
    setState(() {
      isLoading = true;
      if (isLoading) {
        IsShowDialog().showLoadingDialog(context);
      } else {
        Navigator.of(context).pop();
      }
    });
    ListNotificationResponse listNotificationResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:7070/api/noti/"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder()
              .convert(listNotificationRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to list notification $error");
      rethrow;
    }
    if (body == null) return ListNotificationResponse.buildDefault();
    //get data from api here
    listNotificationResponse = ListNotificationResponse.fromJson(body);

    List<NotificationObjectResponse> notificationResponseList = [];
    if (listNotificationResponse
            .dataListNotificationResponse?.listNotificationsResponse !=
        null) {
      for (int i = 0;
          i <
              listNotificationResponse.dataListNotificationResponse!
                  .listNotificationsResponse!.length;
          i++) {
        NotificationObjectResponse notificationObjectResponse =
            listNotificationResponse
                .dataListNotificationResponse!.listNotificationsResponse![i];
        notificationResponseList.add(NotificationObjectResponse(
          notificationObjectResponse.content ??= "",
          notificationObjectResponse.id ??= "",
        ));
      }
    }
    if (listNotificationResponse.status == true) {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
          if (listNotificationResponse.dataListNotificationResponse!
                  .listNotificationsResponse!.isNotEmpty &&
              listNotificationResponse.dataListNotificationResponse!
                      .listNotificationsResponse !=
                  null) {
            listNotification = listNotificationResponse
                .dataListNotificationResponse!.listNotificationsResponse;
          }
        }
      });
    } else {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "list notification empty!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16);
        }
      });
    }

    return listNotificationResponse;
  }

  @override
  Widget build(BuildContext context) {
    return listNotification != null && listNotification!.isNotEmpty
        ? Expanded(
            child: ListView.builder(
                itemCount: listNotification!.length,
                itemBuilder: (context, index) {
                  return notificationItemList(context, index);
                }))
        : const SizedBox();
  }

  Widget notificationItemList(BuildContext context, index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.notifications,
            color: Colors.green,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            margin: const EdgeInsets.only(left: 12),
            child: Text(
              listNotification![index].content!,
            ),
          )
        ],
      ),
    );
  }
}
