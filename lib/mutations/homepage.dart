import 'package:flutter/material.dart';
import 'package:graph_ql/mutations/addingData.dart';
import 'package:graph_ql/mutations/deletingData.dart';
import 'package:graph_ql/mutations/updatingData.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../Configuration/conf.dart';


class HomePage extends StatelessWidget {
  String query = """query lookupCustomerOrder {
  customer {
    first_name
    email
  }
}""";

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: Scaffold(
          appBar: AppBar(
            title: Text("GraphlQL Client"),
          ),
          floatingActionButton: SpeedDial(child: Icon(Icons.add),
              speedDialChildren: [
                SpeedDialChild(child: Icon(Icons.insert_chart),label: 'Add Data', onPressed: (){Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddData()),
                );}),
                SpeedDialChild(child: Icon(Icons.update),label: 'Update Data', onPressed: (){Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UpdateData()),
                );}),
                SpeedDialChild(child: Icon(Icons.delete), label: 'Delete Data',onPressed: (){Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DeletingData()),
                );}),
                SpeedDialChild(child: Icon(Icons.refresh),label: 'Refresh Screen', onPressed: (){Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );})
              ]
          ),


          body: Query(
            options: QueryOptions(
              document: gql(query), // this is the query string you just created
            ),
            // Just like in apollo refetch() could be used to manually trigger a refetch
            // while fetchMore() can be used for pagination purpose
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              // print('result ${result.data}');
              if (result.hasException) {
                print('hasException');
                return Text(result.exception.toString());
              }

              if (result.isLoading) {
                return const Text('Loading');
              }

              List? repositories = result.data?['customer'];
              // print('rep $repositories');

              if (repositories == null) {
                return const Text('No repositories');
              }

              return ListView.builder(
                itemCount: repositories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(repositories[index]['first_name']),
                    subtitle: Text(repositories[index]['email']),
                  );
                },
              );
            },
          )),
    );
  }
}