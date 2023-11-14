import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _sliderValue = 0.0;
  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    _loadSliderAndSwitchValues();
  }

  void _loadSliderAndSwitchValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _sliderValue = prefs.getDouble('sliderValue') ?? 0.0;
      _switchValue = prefs.getBool('switchValue') ?? false;
    });
  }

  void _saveSliderValue(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('sliderValue', value);
  }

  void _saveSwitchValue(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('switchValue', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Slider', style: TextStyle(fontSize: 18)),
            Slider(
              value: _sliderValue,
              onChanged: (newValue) {
                setState(() {
                  _sliderValue = newValue;
                  _saveSliderValue(newValue);
                });
              },
              min: 0,
              max: 100,
            ),
            Text('Switch', style: TextStyle(fontSize: 18)),
            Switch(
              value: _switchValue,
              onChanged: (newValue) {
                setState(() {
                  _switchValue = newValue;
                  _saveSwitchValue(newValue);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}