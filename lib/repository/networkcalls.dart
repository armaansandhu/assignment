import 'package:firebase_database/firebase_database.dart';

import '../model.dart';

class NetworkCalls{
  final db = FirebaseDatabase.instance;

  Stream<Event> init(){
    return db.reference().onValue;
  }

  Future uploadData(Model model)async{
    String id = db.reference().push().key;
    model.id = id;
    await db.reference().child(id).set(model.toJson());
  }

}

final NetworkCalls networkCalls = NetworkCalls();