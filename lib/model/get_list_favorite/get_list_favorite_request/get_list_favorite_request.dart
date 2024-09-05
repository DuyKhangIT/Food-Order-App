class GetListFavoriteRequest {
  String username = "";

  GetListFavoriteRequest(this.username);

  Map<String, dynamic> toBodyRequest() => {
        'username': username,
      };
}
