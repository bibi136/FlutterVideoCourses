

import 'package:flutter/material.dart';

class VideoItem extends StatelessWidget {
  final video;

  const VideoItem({this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image(
          image: NetworkImage(video["imageUrl"]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image(
                  width: 40,
                  height: 40,
                  fit: BoxFit.fill,
                  image: NetworkImage(video["channel"]["profileImageUrl"]),
                ),
              ),
              SizedBox(width: 10.0),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      video["name"],
                      softWrap: true,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.0),
                    ),
                    Text(
                      "${video["channel"]["name"]} • ${video["numberOfViews"]} views",
                      style: TextStyle(fontSize: 14.0, color: Colors.black54),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}