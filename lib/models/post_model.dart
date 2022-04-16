import 'package:flutter_cg/models/addressModel.dart';

class PostModel {
  String title, body;
  int userId;

  PostModel({this.title = "", this.body = "", this.userId = 0});

  toJson() {
    return {"title": this.title, "body": this.body, "userId": this.userId};
  }
}
