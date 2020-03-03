import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
  
}
class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Pedometer _pedometer;
  StreamSubscription<int> _subscription;
  String _stepCountValue = 'unknown';

  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];
  @override
  Widget build(BuildContext context) {
    
    var scaffold = Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
         //color: Colors.red[300],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Divider(),
            Row( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.directions_walk),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Step counter: $_stepCountValue'),
               ),                          
            ]
            ),
          ],
        ),
        margin: const EdgeInsets.all(8.0),
      ),
      drawer: Drawer(
        child: Text('this is a drawer',
                      style: Theme.of(context).textTheme.headline6,),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SecondRoute()),);
        },
        ),
      bottomNavigationBar: BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Container(height: 50.0,),
      color: Colors.red,
    ),
      
    );
    return scaffold;
  }
  
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
    void initState() {
    super.initState();
    initPlatformState();
    
  }

  Future<void> initPlatformState() async {
    startListening();
  }
  void onData(int stepCountValue) {
    print(stepCountValue);
  }

  void startListening() {
    _pedometer = new Pedometer();
    _subscription = _pedometer.pedometerStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }
 void stopListening() {
    _subscription.cancel();
  }

  void _onData(int stepCountValue) async {
    setState(() => _stepCountValue = "$stepCountValue");
  }
 

  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");


}
