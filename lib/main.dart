import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import './http.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      home: new RandomWords(),
    );
  }
  // Widget build(BuildContext context) {
  //   final wordPair = new RandomWords();
  //   return new MaterialApp(
  //     title: 'Welcome to Flutter',
  //     home: new Scaffold(
  //       appBar: new AppBar(
  //         title: new Text('Welcome to Flutter'),
  //       ),
  //       body: new Center(
  //         // child: new Text('Hello World'),
  //         child: wordPair,
  //       ),
  //     ),
  //   );
  // }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = [];
  final _biggerFont = const TextStyle(fontSize: 12);
  String _title = "获取所有诗句种类";
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(_title),
        ),
        body: _buildSuggestions(context));
  }

  _buildRow(WordPair pair) {
    return new ListTile(
      title: new Text(pair.asPascalCase, style: _biggerFont),
    );
  }

  _buildSuggestions(BuildContext context) {
    return new Container(
      child: new FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString("data/category.json"),
        builder: (context, snapshot) {
          String data = snapshot.data.toString();
          Map str = json.decode(data);
          List list = [];
          str.keys.toList().forEach((item) {
            list.add({'label': str[item], 'value': item});
          });
          return new ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: list.length * 2,
            itemBuilder: (contenx, i) {
              if (i.isOdd) return new Divider();
              final index = i ~/ 2;
              return new FlatButton(
                  child: new Text(list[index]['label']),
                  onPressed: () async {
                    final res =
                        await getVerseCategory(list[index]['value'], {});
                    // this._title = ;
                    Fluttertoast.showToast(
                        msg: res.data['content'],
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    // print(this._title);
                  });
            },
          );
        },
      ),
    );
    // return new ListView.builder(
    //     padding: const EdgeInsets.all(12),
    //     itemCount: 10,
    //     itemBuilder: (context, i) {
    //       print(i);
    //       if (i ==0) {
    //         return new RaisedButton(
    //           onPressed: () async {
    //             // final data = await getVerseCategory({});
    //             // print(data);
    //             // _suggestions.addAll(data.list);
    //           },
    //           child: Text("test"),
    //           textColor: Color(0xffff0000),
    //           color: Color(0xfff1f1f1),
    //           highlightColor: Color(0xff00ff00),
    //         );
    //       }
    //       if (i.isOdd) return new Divider();
    //       Future load = ;
    //       load.then((onValue){
    //           print(onValue);
    //       });
    //       // final index = i ~/ 2;
    //       // if (index >= _suggestions.length) {
    //       //   // ...接着再生成10个单词对，然后添加到建议列表
    //       //   _suggestions.addAll(generateWordPairs().take(10));
    //       // }
    //       // _suggestions.add("fasasdf");
    //       return new Text("1111");
    //       // return _buildRow(_suggestions[index]);
    //     });
  }
}
