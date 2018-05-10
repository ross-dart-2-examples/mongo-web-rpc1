//import 'package:dart_mongo_server_rpc1/dart_mongo_server_rpc1.dart' as dart_mongo_server_rpc1;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rpc/rpc.dart';
import 'dart:io' as io;
import 'package:dart_mongo_server_rpc1/model.dart';
import 'dart:async';



@ApiClass(version: 'v1', name: 'cloud')
class Cloud {
  final List<Name> names = new List();

 @ApiMethod(path: 'list', method: 'GET')
 Future<List<Name>> makeList() async {
  // List names = new List();
   names.clear();
   Db db = new Db('mongodb://localhost:27017/rpc1');
   await db.open();
   DbCollection collection = db.collection('names');
     await collection.find().forEach((Map element) {
       Name name = new Name()
       ..firstName = element['firstName']
       ..lastName = element['lastName'];
 //      print(name);
       names.add(name);
     });
     await db.close();
   return names;
 }

  @ApiMethod(path: 'add', method: 'POST')
  Name add(Name name) {
  //  DbName newName = new DbName();
    Db db = new Db('mongodb://localhost:27017/rpc1');
    db.open().then((_){
      DbCollection collection = db.collection('names');
      collection.insert(name.toMap()).then((Map map) {
        print(map);
    //    newName.id = map['_id'];
    //    newName.firstName = map['firstName'];
    //    newName.lastName = map['lastName'];
        db.close();
      });
    });
    return name;
  }
}

final ApiServer _apiServer = new ApiServer(prettyPrint: true);

main(List<String> arguments) async {
//  print('Hello world: ${dart_mongo_server_rpc1.calculate()}!');

  _apiServer.addApi(new Cloud());
  io.HttpServer server = await io.HttpServer.bind('127.0.0.1', 8000);
  server.listen(_apiServer.httpRequestHandler);

}
