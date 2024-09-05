import 'data_change_account_response.dart';

class ChangeAccountResponse {
  bool status = false;
  DataChangeAccountResponse? dataChangeAccountResponse;

  ChangeAccountResponse(
    this.status,
    this.dataChangeAccountResponse,
  );
  ChangeAccountResponse.buildDefault();
  factory ChangeAccountResponse.fromJson(Map<String, dynamic> json) {
    return ChangeAccountResponse(
      json['status'],
      (json['data'] != null)
          ? DataChangeAccountResponse.fromJson(json['data'])
          : null,
    );
  }
}
