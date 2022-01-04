import 'package:flutter/material.dart';
import 'package:json_provider/news_data.dart';
import 'package:json_provider/stories_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (context) => NewsData(),
        builder: (context, child){
          return const StoriesPage();
        },
      ),
    );
  }
}

