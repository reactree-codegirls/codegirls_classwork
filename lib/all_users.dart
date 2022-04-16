import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cg/models/post_model.dart';
import 'package:flutter_cg/models/user_model.dart';

class AllUsersSCreen extends StatefulWidget {
  @override
  State<AllUsersSCreen> createState() => _AllUsersSCreenState();
}

class _AllUsersSCreenState extends State<AllUsersSCreen> {
  TextEditingController bodyTextController = TextEditingController();

  List<UserModel> globalUsers = [];

  getAllUsers() async {
    List<UserModel> usersList = [];
    try {
      var response =
          await Dio().get('https://jsonplaceholder.typicode.com/users');

      if (response.statusCode == 200) {
        List<dynamic> allUsersRawData = response.data;

        for (int i = 0; i < allUsersRawData.length; i++) {
          UserModel _userModel = UserModel.fromJson(allUsersRawData[i]);
          print(_userModel.name);
          usersList.add(_userModel);
        }
        print(usersList.length);
        setState(() {
          // globalUsers.addAll(usersList);
          globalUsers = usersList;
        });
        print("Global list length: " + globalUsers.length.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  createAPost() async {
    PostModel postModel = PostModel(
        body: bodyTextController.text, title: "this is the title", userId: 1);

    try {
      var response = await Dio().post(
          'https://jsonplaceholder.typicode.com/posts',
          data: postModel.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("The Record has been posted successfully");
        print(response.data);
      } else {
        print("Errorrr ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  deleteAPost(String id) async {
    try {
      var response = await Dio().delete(
        'https://jsonplaceholder.typicode.com/posts/$id',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("The Record has been Deleted successfully");
      } else {
        print("Errorrr ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Users"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          TextField(
            controller: bodyTextController,
          ),
          ElevatedButton(
              onPressed: () {
                getAllUsers();
              },
              child: Text("Get All Users")),
          ElevatedButton(
              onPressed: () {
                deleteAPost("1");
              },
              child: Text("Delete Post")),
          ElevatedButton(
              onPressed: () {
                createAPost();
                // print(bodyTextController.text);
              },
              child: Text("Create a Post")),
          ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: globalUsers.length,
              itemBuilder: (_, i) {
                return InkWell(onTap: () {}, child: Text(globalUsers[i].name));
              })
        ],
      )),
    );
  }
}
