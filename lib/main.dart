import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cg/all_users.dart';
import 'package:flutter_cg/models/user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int id = 0;

  String name = 'Default', username = 'Default', email = 'Default';
  UserModel userModel = UserModel(name: "", email: "", userName: "");
  bool loading = false;
  Future<void> getUserByID({String id = '1'}) async {
    try {
      setState(() {
        loading = true;
      });
      var response =
          await Dio().get('https://jsonplaceholder.typicode.com/users/$id');
//      print(response);
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200 &&
          (response.data as Map<String, dynamic>).isNotEmpty) {
        setState(() {
          // this.id = response.data['id'];
          // name = response.data['name'];
          // username = response.data['username'];
          // email = response.data['email'];
          userModel = UserModel.fromJson(response.data);
        });
        print(userModel.address.street);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    getUserByID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Networking w APIs'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            loading == true ? CircularProgressIndicator() : Container(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return AllUsersSCreen();
                }));
              },
              child: Text("All Users"),
            ),
            Text(
              userModel.name,
              style: TextStyle(fontSize: 30),
            ),
            // Text('ID: ${userModel.}'),
            Text('Name: ${userModel.name}'),
            Text('Username: ${userModel.userName}'),
            Text('Email: ${userModel.email}'),

            Text(
              "Address Details",
              style: TextStyle(fontSize: 30),
            ),
            userModel.address != null
                ? Text('Street: ${userModel.address.street}')
                : Container(),
            userModel.address != null
                ? Text('City: ${userModel.address.city}')
                : Container(),
          ],
        ),
      ),
    );
  }
}
