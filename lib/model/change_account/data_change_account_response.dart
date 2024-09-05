import 'package:food_app_project/model/change_account/user_change_account_response.dart';

class DataChangeAccountResponse {
  UserChangeAccountResponse? userChangeAccountResponse;

  DataChangeAccountResponse(
    this.userChangeAccountResponse,
  );
  DataChangeAccountResponse.buildDefault();
  factory DataChangeAccountResponse.fromJson(Map<String, dynamic> json) {
    return DataChangeAccountResponse(
      (json['user'] != null)
          ? UserChangeAccountResponse.fromJson(json['user'])
          : null,
    );
  }
}
