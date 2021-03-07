import 'dart:io';

import 'package:azure_mixed_reality_auth/azure_mixed_reality_auth.dart';
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart' show env, isEveryDefined, load;

void main() {
  group('Azure Mixed Reality Auth Tests', () {
    AzureMixedRealityAuthRepository repository;

    setUp(() {
      load();
      const _required = [
        'azure_client_id',
        'azure_client_secret',
        'azure_tenant_id',
        'azure_spatial_anchors_account_id',
        'azure_spatial_anchors_account_domain'
      ];
      expect(isEveryDefined(_required), true);

      repository = AzureMixedRealityAuthRepository(
          clientId: env['azure_client_id'],
          clientSecret: env['azure_client_secret'],
          tenantId: env['azure_tenant_id'],
          spatialAnchorsAccountId: env['azure_spatial_anchors_account_id'],
          spatialAnchorsAccountDomain:
              env['azure_spatial_anchors_account_domain']);
    });

    test('Get App Token', () async {
      var token = await repository.getAADAppToken();
      expect(token.isNotEmpty, true);
    });

    test('Get ASA Access Token', () async {
      var token = await repository.getASAAccessToken();
      expect(token.isNotEmpty, true);
    });
  });
}
