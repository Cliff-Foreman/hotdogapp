import 'dart:convert';

import 'package:app/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:io' as IO;
import 'package:dio/dio.dart';
import 'package:image/image.dart' as im;
import 'package:image_picker/image_picker.dart';

var result = "N";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  var _result = null;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    var bytes = base64Url.encode(IO.File(image.path).readAsBytesSync());

    setState(() {
      _image = image;
      _result = "Loading";
    });

    print("Here");
    Response response;
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "img": bytes,
    });
    response = await dio.post("http://hotdognotdog.herokuapp.com/", data: formData);

    print(response.data.toString());

    setState(() {
      _image = image;
      _result = response.data['ans'].toString();
    });
  }

  Future<void> _optos() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rewind and remember'),
          actions: <Widget>[
            FlatButton(
              child: Text('Camera'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Gallery'),
              onPressed: () {
                getImage();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget imgOptions() {
    if (_image == null) {
      return Text('');
    } else {
      return Column(
        children: <Widget>[
          Container(
            width: 350,
            decoration: new BoxDecoration(
              color: Colors.red,
            ),
            child: Image.file(_image),
            margin: new EdgeInsets.only(top: 10),
          ),
          Container(
            child: Text(
              _result,
              style: new TextStyle(fontSize: 24),
            ),
            margin: new EdgeInsets.only(top: 75),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(36)),
            ClipRRect(
              child: Container(
                child: imgOptions(),
              ),
            ),
            Container(
              child: RaisedButton(
                onPressed: _optos,
                child: Text("Submit"),
              ),
              margin: new EdgeInsets.only(top: 75),
            ),
          ],
        ),
      ),
    );
  }
}
