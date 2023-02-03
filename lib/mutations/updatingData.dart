import 'package:flutter/material.dart';
import 'package:graph_ql/mutations/homepage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../Configuration/conf.dart';

class UpdateData extends StatefulWidget {
  const UpdateData({Key? key}) : super(key: key);

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  String update = """
  mutation MyMutation(\$first_name:String!,\$email:String!) {
  update_customer(where: {first_name: {_eq: \$first_name}}, _set: {email: \$email}) {
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
                document: gql(update),
                update: (cache, result) {
                  return cache;
                },
                onCompleted: (dynamic resultData) {
                  print('result Data $resultData');
                },
              ),
              builder: (runMutationUpdate, resultUpdate) {
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
                      TextField(
                        decoration:
                            InputDecoration(label: Text('Update Email')),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            runMutationUpdate({
                              'first_name': nameController.text,
                              'email': emailController.text,
                            });
                            Navigator.of(context).pop('refresh');
                            // Navigator.of(context).pushAndRemoveUntil(
                            //     MaterialPageRoute(
                            //         builder: (context) => HomePage()),
                            //     (route) => false).then((_) => setState(() {}));
                          },
                          child: Text('Update')),
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
