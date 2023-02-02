import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../Configuration/conf.dart';
import 'homepage.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  String mutation = """
  mutation InsertCustomer(\$id: Int, \$first_name: String, \$last_name: String, \$email: String, \$phone: String, \$username: String, \$ip_address: String) {
  insert_customer(objects: {id: \$id, first_name: \$first_name, last_name: \$last_name, email: \$email, phone: \$phone, username: \$username, ip_address: \$ip_address}) {
    affected_rows
    returning {
      email
      first_name
      id
      ip_address
      last_name
    }
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
              title: Text('GraphQL Insert'),
            ),
            body: Mutation(
              options: MutationOptions(
                document: gql(mutation),
                update: (cache, result) {
                  return cache;
                },
                onCompleted: (dynamic resultData) {
                  print('result Data $resultData');
                },
              ),
              builder: (runMutation, result) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(label: Text('ID')),
                        controller: idController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(label: Text('Email')),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(label: Text('Name')),
                        controller: nameController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            runMutation({
                              'id': int.parse(idController.text),
                              'first_name': nameController.text,
                              'email': emailController.text,
                              'last_name': null,
                              'phone': null,
                              'username': null,
                              'ip_address': null
                            });
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                builder: (context) => HomePage()), (route) => false);
                          },
                          child: Text('Insert')),


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
