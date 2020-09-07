import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/shared/shared.dart';
import 'package:pamiksa/src/data/graphql/mutations/mutations.dart' as mutations;

class DeviceRepository {
  final GraphQLClient client;
  Shared preferences = Shared();

  DeviceRepository({@required this.client}) : assert(client != null);

  Future<QueryResult> sendDeviceInfo(
      DeviceModel deviceModel, String userId) async {
    final MutationOptions _options = MutationOptions(
      documentNode: gql(mutations.sendDeviceInfo),
      variables: {
        'plattform': deviceModel.platform,
        'systemVersion': deviceModel.systemVersion,
        'deviceId': deviceModel.deviceId,
        'model': deviceModel.model,
        'userFk': userId
      },
    );
    return await client.mutate(_options);
  }
}
