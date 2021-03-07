import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class AzureMixedRealityAuthRepository {
  final String spatialAnchorsAccountId;
  final String spatialAnchorsAccountDomain;
  final String clientId;
  final String clientSecret;
  final String tenantId;

  final String spatialAnchorsResource = 'https://sts.mixedreality.azure.com';
  final http.Client client;

  AzureMixedRealityAuthRepository({
    @required this.clientId,
    @required this.clientSecret,
    @required this.tenantId,
    @required this.spatialAnchorsAccountId,
    @required this.spatialAnchorsAccountDomain,
  }) : client = http.Client();

  Future<String> getAADAppToken() async {
    var url = Uri.https('login.microsoftonline.com', '/$tenantId/oauth2/token');
    var response = await client.post(url, body: {
      'grant_type': 'client_credentials',
      'resource': spatialAnchorsResource,
      'client_id': clientId,
      'client_secret': clientSecret,
    });

    var json = jsonDecode(response.body);
    return json['access_token'] as String;
  }

  Future<String> getASAAccessToken() async {
    // get AAD App Token
    var appToken = await getAADAppToken();

    // get ASA Access Token
    var url = Uri.https('sts.$spatialAnchorsAccountDomain',
        '/Accounts/$spatialAnchorsAccountId/token');
    var response =
        await client.get(url, headers: {'Authorization': 'Bearer $appToken'});

    var json = jsonDecode(response.body);
    return json['AccessToken'] as String;
  }
}
