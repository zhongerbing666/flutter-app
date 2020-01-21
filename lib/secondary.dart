import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import './http.dart';
import './storage.dart';

class SecondaryWidget extends StatefulWidget {
  @override
  createState() => new Secondary();
}

class Secondary extends State<SecondaryWidget> {
  List arr = [];

  @override
  void initState() {
    pref.then((res) {
      Object arguments = ModalRoute.of(context).settings.arguments;
      Map routeArg = arguments;
      Map map = json.decode(res);
      List<String> list = map.keys.toList();
      List data = [];
      list.forEach((item) {
        if (item.contains(routeArg['key']) && item != routeArg['key']) {
          data.add({'label': map[item], 'value': item});
        }
      });
      setState(() {
        arr = data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("获取所有诗句种类"),
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return new ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: this.arr.length * 2 - 1,
        itemBuilder: (contenx, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          return new FlatButton(
              child: new Text(this.arr[index]['label']), onPressed: () async{
                final res = await getVerseCategory(this.arr[index]['value'], {});
                Fluttertoast.showToast(
                    msg: res.data['content'],
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0);
              });
        });
  }
}
