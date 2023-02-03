import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink httpLink = HttpLink(defaultHeaders: {
  'content-type': 'application/json',
  'x-hasura-admin-secret':
  'Abcx1AlxMBvXTGfAH8kx86n7ngS14Png3Q5rw4s28U5leVo51nQFai8tK42Rsq2Y'
}, "https://brave-anteater-85.hasura.app/v1/graphql");
final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
  GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  ),
);