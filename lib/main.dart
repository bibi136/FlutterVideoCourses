import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './views/video_cell.dart';
import 'detail_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RealWorldApp(),
    );
  }
}

class RealWorldApp extends StatefulWidget {
  @override
  _RealWorldAppState createState() => _RealWorldAppState();
}

class _RealWorldAppState extends State<RealWorldApp> {
  var _isLoading = true;
  final videos = List();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Real world appbar"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              print("Reloading...");
              setState(() {
                _isLoading = true;
              });
              _fetchData();
            },
          )
        ],
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : new ListView.separated(
                separatorBuilder: (context, i) {
                  return Divider(
                    height: 16.0,
                    color: Colors.transparent,
                  );
                },
                itemBuilder: (context, index) {
                  return FlatButton(
                    child: VideoItem(video: videos[index]),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailPage(videos[index]["id"]);
                      }));
                    },
                  );
                },
                itemCount: videos.length,
              ),
      ),
    );
  }

  void _fetchData() async {
    print("Attempting to fetch data from network");

    final url = "http://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        videos.clear();
        videos.addAll(json.decode(response.body)["videos"]);
        _isLoading = false;
      });
    }
  }
}
