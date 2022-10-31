import 'package:flutter/material.dart';
import 'package:sexigesimal_alpha/number_typing/character_typing_page.dart';
import 'package:sexigesimal_alpha/number_typing/number_keyboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const NumberTypingPage(), //TODO
    );
  }
}
