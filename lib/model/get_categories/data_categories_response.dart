import 'categories_response.dart';

class DataCategoriesResponse {
  List<CategoriesResponse>? listCategories;

  DataCategoriesResponse(
    this.listCategories,
  );

  factory DataCategoriesResponse.fromJson(Map<String, dynamic> json) {
    List<CategoriesResponse> categoriesResponse = [];
    if (json['categories'] != null) {
      List<dynamic> arrData = json['categories'];
      for (var i = 0; i < arrData.length; i++) {
        categoriesResponse.add(
            CategoriesResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return DataCategoriesResponse(
      categoriesResponse,
    );
  }
}
