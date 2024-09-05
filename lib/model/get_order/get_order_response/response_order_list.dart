import 'order_detail_response_get.dart';

class ResponseOrderList{
    String orderId = "";
    String userName = "";
    String createOnDate = "";
    int total = 0;
    List<OrderDetailResponseGet>? orderDetailResponseGet;
    bool orderStatus = false;

    ResponseOrderList(this.orderId, this.userName, this.createOnDate, this.total,
        this.orderDetailResponseGet,this.orderStatus);

    ResponseOrderList.buildDefault();
    factory ResponseOrderList.fromJson(Map<String, dynamic> json) {
        List<OrderDetailResponseGet> orderDetailResponseGet = [];
        if (json['orderDetail'] != null) {
            List<dynamic> arrData = json['orderDetail'];
            for (var i = 0; i < arrData.length; i++) {
                orderDetailResponseGet.add(
                    OrderDetailResponseGet.fromJson(arrData[i] as Map<String, dynamic>));
            }
        }
        return ResponseOrderList(
            json['_id'],
            json['username'],
            json['createOnDate'],
            json['total'],
            orderDetailResponseGet,
            json['status'],
        );
    }
}