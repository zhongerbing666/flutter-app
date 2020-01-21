import 'package:flutter/material.dart';
import './http.dart';
import 'dart:convert';
import './storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerseList extends StatefulWidget {
  @override
  createState() => new VerseListState();
}

class VerseListState extends State<VerseList> {
  Future future;
  List data;
  @override
  void initState() {
    future = DefaultAssetBundle.of(context).loadString("data/category.json");
    pref = future;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("诗句"),
        ),
        body: _buildBody(context));
  }

  _buildBody(BuildContext context) {
    return new Container(
      child: new FutureBuilder(
        future: this.future,
        builder: _buildVerseList,
      ),
    );
  }

  Widget _buildVerseList(BuildContext context, AsyncSnapshot snapshot) {
    List list = _getListData(snapshot);
    return new ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: list.length * 2 - 1,
      itemBuilder: (contenx, i) {
        if (i.isOdd) return new Divider();
        final index = i ~/ 2;
        final children = [
          new FlatButton(
              child: new Text(list[index]['label']+'-二级分类'),
              onPressed: () async {
                if (i == 0) return;
                Navigator.pushNamed(context, "/secondary",
                    arguments: {"key": list[index]['value']});
              }),
          new FlatButton(
              child: new Text('显示当前分类'),
              onPressed: () async {
                final res = await getVerseCategory(list[index]['value'], {});
                Fluttertoast.showToast(
                    msg: res.data['content'],
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }),
        ];
        return new Row(
            children: children,
            mainAxisAlignment: MainAxisAlignment.spaceAround);
      },
    );
  }

  /* 
    获取本地json数据
   */
  List _getListData(AsyncSnapshot<dynamic> snapshot) {
    String data = snapshot.data.toString();
    Map str = json.decode(data);
    List list = [];
    List<String> keys = str.keys.toList();
    // print(str);
    keys.forEach((item) {
      if (!item.contains("/")) {
        list.add({'label': str[item], 'value': item});
      }
    });
    return list;
  }
}
