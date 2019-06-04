import 'package:assignments/utils.dart';
import 'package:flutter/material.dart';

import 'bloc.dart';
import 'model.dart';
import 'nextpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Color(0xff242157)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Size size() => MediaQuery.of(context).size;

  ///Input variables
  DateTime _date = DateTime.now();
  DateTime _time = DateTime.now();
  String _description;
  String _client;
  String _job;
  String _notes;

  final TextStyle lableStyle = TextStyle(
      color: Color(0xff242157), fontSize: 18, fontWeight: FontWeight.w600);
  final TextStyle inputStyle =
      TextStyle(color: Color(0xff242157), fontSize: 18);
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  ///FormStateKey to manage form state and validate data
  final GlobalKey<FormState> _formKey = GlobalKey();

  ///Colors
  final textfieldBgColor = Colors.blueGrey.withOpacity(.05);

  Utils utils = Utils();

  void onSave() async {
    _formKey.currentState.save();
    Bloc().upload(Model.fromData(
        utils.dateFormatter(_date),
        utils.timeFormatter(_time),
        _description,
        _client,
        _job,
        _notes,
        _time.millisecondsSinceEpoch,
        _time.toUtc().millisecondsSinceEpoch));

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NextPage()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _bodyContent(),
      ),
    );
  }

  Widget _appBar() {
    return Container(
      color: Theme.of(context).primaryColor,
      height: MediaQuery.of(context).size.height * .1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: null),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: onSave,
              child: Container(
                height: size().height * .06,
                width: size().width * .3,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _bodyContent() {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        _appBar(),
        Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _dateAndHour(),
                _appointmentDescription(),
                _clientAndJob(),
                _notesWidget()
              ],
            ))
      ],
    ));
  }

  Widget _dateAndHour() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Card(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '  Date',
                      style: lableStyle,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var pickedDate = await utils.pickDate(context, _date);
                        setState(() {
                          _date = pickedDate;
                        });
                      },
                      child: Container(
                          height: size().height * .055,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              color: Colors.blueGrey.withOpacity(.1),
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.5))),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              utils.dateFormatter(_date),
                              style: inputStyle,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          )),
          Expanded(
              child: Card(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'Hour  ',
                      style: lableStyle,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var timePicked = await utils.pickTime(context, _time);
                        setState(() {
                          _time = timePicked;
                        });
                      },
                      child: Container(
                          height: size().height * .055,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              color: Colors.blueGrey.withOpacity(.1),
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.5))),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              utils.timeFormatter(_time),
                              style: inputStyle,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _appointmentDescription() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '  Appointment Description',
                style: lableStyle,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: textfieldBgColor,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Optional',
                  ),
                  style: inputStyle,
                  onSaved: (val) {
                    setState(() {
                      _description = val;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _clientAndJob() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '  Client',
                      style: lableStyle,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: textfieldBgColor,
                            ),
                            child: TextFormField(
                              controller: _clientController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Optional',
                              ),
                              style: inputStyle,
                              onSaved: (val) {
                                setState(() {
                                  _client = val;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: size().height * .04,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _clientController.text = '';
                                  });
                                }))
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '  Job',
                        style: lableStyle,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: textfieldBgColor,
                              ),
                              child: TextFormField(
                                controller: _jobController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Optional',
                                ),
                                style: inputStyle,
                                onSaved: (val) {
                                  setState(() {
                                    _job = val;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: size().height * .04,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _jobController.text = '';
                                    });
                                  }))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _notesWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '  Notes',
                style: lableStyle,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: textfieldBgColor,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Optional',
                  ),
                  style: inputStyle,
                  onSaved: (val) {
                    setState(() {
                      _notes = val;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
