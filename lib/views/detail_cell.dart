import 'package:flutter/material.dart';

class DetailCell extends StatelessWidget {
  final video;

  const DetailCell(this.video);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Stack(
            children: <Widget>[
              Image(image: NetworkImage(video["imageUrl"])),
              Positioned(
                bottom: 2,
                right: 2,
                child: Text(
                  "${video["duration"]}",
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                      backgroundColor: Colors.black87),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  video["name"],
                  softWrap: true,
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(
                  "Espisole #${video["number"]}",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
