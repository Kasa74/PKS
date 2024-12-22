import 'package:flutter/material.dart';
import 'package:flutter_task3/presentation/screens/MainRouter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue[800],
          canvasColor: Colors.grey[850],
          cardColor: Colors.grey[800],
          dialogBackgroundColor: Colors.grey[700],
          dividerColor: Colors.grey[600],
        ),
      home: const MainRouter()
    );
  }
}
