import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'views/detail_cell.dart';

class DetailPage extends StatelessWidget {
  final categoryId;

  DetailPage(this.categoryId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail Page"),
        ),
        body: BodyContent(categoryId));
  }
}

class BodyContent extends StatefulWidget {
  final categoryId;

  BodyContent(this.categoryId);

  @override
  _BodyContentState createState() => _BodyContentState();
}

class _BodyContentState extends State<BodyContent> {
  var isLoading = true;
  final videos = List();

  @override
  void initState() {
    loadCategory(widget.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? CircularProgressIndicator()
          : ListView.separated(
              padding: EdgeInsets.all(8.0),
              itemBuilder: (context, i) {
                return DetailCell(videos[i]);
              },
              separatorBuilder: (context, i) {
                return Divider(color: Colors.transparent);
              },
              itemCount: videos.length),
    );
  }

  void loadCategory(categoryId) async {
    var queryParameter = {'id': categoryId.toString()};
    final url = "api.letsbuildthatapp.com";

    var uri = Uri.https(url, "/youtube/course_detail", queryParameter);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        videos.clear();
        videos.addAll(jsonDecode(response.body));
      });
    }
  }
}
