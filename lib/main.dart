import 'package:flutter/material.dart';
import './mutations/homepage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './Configuration/conf.dart';

void main() async {
  await initHiveForFlutter();
  runApp(MaterialApp(title: "GQL App", home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      child: HomePage(),
      client: client,
    );
  }
}


