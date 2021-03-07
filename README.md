A library for Dart developers.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

## Usage

A simple usage example:

```dart
import 'package:azure_mixed_reality_auth/azure_mixed_reality_auth.dart';
import 'package:dotenv/dotenv.dart' show env, load;

void main() async {
  load();
  var repository = AzureMixedRealityAuthRepository(
      clientId: env['azure_client_id'],
      clientSecret: env['azure_client_secret'],
      tenantId: env['azure_tenant_id'],
      spatialAnchorsAccountId: env['azure_spatial_anchors_account_id'],
      spatialAnchorsAccountDomain: env['azure_spatial_anchors_account_domain']);
  var accessToken = await repository.getASAAccessToken();
  print(accessToken);
}
```
