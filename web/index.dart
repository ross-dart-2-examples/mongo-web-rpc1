import 'dart:html';
//import 'package:dart_mongo_server_rpc1/model.dart';
import 'dart:convert';
//import 'dart:async';

main() async{
  UListElement element = querySelector('#list');

AnchorElement anchorElement = querySelector('#listLink')
    ..onClick.listen((_) {
      element.children.clear();
      HttpRequest.getString("http://127.0.0.1:8000/cloud/v1/list").then((String response){
        var raw = jsonDecode(response);
        for (Map m in raw) {
          LIElement liElement = new LIElement();
          liElement.text = "${m['firstName']} ${m['lastName']}";
          element.append(liElement);
        }
      });
    });

}