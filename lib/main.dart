import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp( const MyApp1());
}

class NativeCommunication {
  static const platform = MethodChannel('com.example.navtive_project/native');

  Future<String> getNativeMessage() async {
    try {
      final String result = await platform.invokeMethod('getMessage');
      return result;
    } on PlatformException catch (e) {
      return "Failed to get message: '${e.message}'.";
    }
  }
}



class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Platform Channel Example'),
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: NativeCommunication().getNativeMessage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Message: ${snapshot.data}');
              }
            },
          ),
        ),
      ),
    );
  }
}


