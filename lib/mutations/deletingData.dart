import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../Configuration/conf.dart';
import 'homepage.dart';


class DeletingData extends StatefulWidget {
  const DeletingData({Key? key}) : super(key: key);

  @override
  State<DeletingData> createState() => _DeletingDataState();
}

class _DeletingDataState extends State<DeletingData> {
  final TextEditingController nameController = TextEditingController();

  String delete = """
  mutation MyMutation(\$first_name:String!) {
  delete_customer(where: {first_name: {_eq: \$first_name}}) {
    affected_rows
  }
}
  """
      .replaceAll('\n', '');

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: client,
        child: Scaffold(
            appBar: AppBar(
              title: Text('GraphQL update'),
            ),
            body: Mutation(
              options: MutationOptions(
                document: gql(delete),
                update: (cache, result) {
                  return cache;
                },
                onCompleted: (dynamic resultData) {
                  print('result Data $resultData');
                },
              ),
              builder: (runMutationDelete, resultDelete) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(label: Text('Name')),
                        controller: nameController,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      ElevatedButton(
                          onPressed: () {
                            runMutationDelete({
                              'first_name': nameController.text,
                            });
                            setState(() {
                              Navigator.pop(context);
                            });

                            // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage()));
                          },
                          child: Text('Delete')),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // ElevatedButton(onPressed: () {}, child: Text('Update')),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // ElevatedButton(onPressed: () {}, child: Text('Detail')),
                    ],
                  ),
                );
              },
            )));
  }
}
