import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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

  Future<void> getUserByID({String id = '1'}) async {
    try {
      var response =
          await Dio().get('https://jsonplaceholder.typicode.com/users/$id');
//      print(response);

      if (response.statusCode == 200 &&
          (response.data as Map<String, dynamic>).isNotEmpty) {

        setState(() {
          this.id = response.data['id'];
          name = response.data['name'];
          username = response.data['username'];
          email = response.data['email'];

          print('ID: $id');
          print('Name: $name');
          print('Username: $username');
          print('Email: $email');
        });
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
            Text('ID: $id'),
            Text('Name: $name'),
            Text('Username: $username'),
            Text('Email: $email'),
          ],
        ),
      ),
    );
  }
}
