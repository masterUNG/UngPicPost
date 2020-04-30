import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungpicpost/widget/add_post.dart';

class ShowListPost extends StatefulWidget {
  @override
  _ShowListPostState createState() => _ShowListPostState();
}

class _ShowListPostState extends State<ShowListPost> {
  // Field
  bool status = true;

  // Method

  @override
  void initState() {
    super.initState();
    readAllPost();
  }

  Future<void> readAllPost() async {
    String url = 'https://www.androidthai.in.th/mai/getAllPostUng.php';

    Response response = await Dio().get(url);
    print('response ==>> $response');

    if (response.toString() != 'null') {
      setState(() {
        status = false;
      });
    }
  }

  Widget showListView() {
    return Text('showListView');
  }

  Widget showNoData() {
    return Center(
      child: Text('No Post Data'),
    );
  }

  Widget addPostButton() {
    return FloatingActionButton(child: Icon(Icons.add),
      onPressed: () {
        MaterialPageRoute route = MaterialPageRoute(builder: (value)=>AddPost());
        Navigator.push(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: status ? showNoData() : showListView(),
      floatingActionButton: addPostButton(),
    );
  }
}
