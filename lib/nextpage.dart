import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'bloc.dart';

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display data'),
      ),
      body: Center(
          child: StreamBuilder(
        stream: Bloc().out,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            //Converts dynamic to Map
            Map data = snapshot.data.snapshot.value;
            return ListView(
                children: data.values
                    .map((item) => ListTile(
                          title: Text(item['id']),
                          subtitle: Text(item['date']),
                        ))
                    .toList());
          } else
            return Text('Loading...');
        },
      )),
    );
  }
}

//
