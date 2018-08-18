import 'dart:html';
//import 'package:dart_mongo_server_rpc1/model.dart';
import 'dart:convert';
// import 'dart:async';

main()  {
  querySelector("#list_link").onClick.listen((_) {
    UListElement uListElement = querySelector("#name_list");
    uListElement.children.clear();
    HttpRequest.getString("http://rossalbertson.dynv6.net:8000/cloud/v1/list").then((response) {
      List raw = jsonDecode(response);
      for (Map<String, dynamic> name in raw) {
        LIElement liElement = new LIElement();
        liElement.text = "${name['firstName']} ${name['lastName']}";
        uListElement.append(liElement);
      }
    });


  });


}