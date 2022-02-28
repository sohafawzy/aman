import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadPhotosScreen extends StatefulWidget {
  @override
  _UploadPhotosScreenState createState() => _UploadPhotosScreenState();
}

class _UploadPhotosScreenState extends State<UploadPhotosScreen> {
  _UploadPhotosScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 0.0),
                    child: Center(
                        child: Image(
                          image: AssetImage('assets/images/ic_aman.jpeg'),
                          width: 200.0,
                          height: 100.0,
                          fit: BoxFit.scaleDown,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
