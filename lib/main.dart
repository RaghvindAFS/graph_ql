import 'package:flutter/material.dart';
import './mutations/deletingData.dart';
import './mutations/homepage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './mutations/addingData.dart';
import './mutations/updatingData.dart';

void main() async {
  await initHiveForFlutter();
  runApp(
    MaterialApp(title: "GQL App", initialRoute: '/', routes: {
      '/': (context) => HomePage(),
      '/AddData': (context) => const AddData(),
      '/UpdateData': (context) => const UpdateData(),
      '/DeleteData': (context) => const DeletingData(),
    }),
  );
}
