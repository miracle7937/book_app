import 'package:local_auth/local_auth.dart';

import '../data_layer/models/user_credential_model.dart';
import 'local_storage_data.dart';

class BiometricController {
  static LocalAuthentication auth = LocalAuthentication();
  // ···
  static Future<bool> isBiometricEnable() async {
    UserCredentialModel? userCredentialModel =
        await LocalDataStorage.getUserCredential();
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    print("BiometricType $availableBiometrics");
    if (availableBiometrics.contains(BiometricType.fingerprint) ||
        availableBiometrics.contains(BiometricType.face) ||
        availableBiometrics.contains(BiometricType.weak)) {
      return true && canAuthenticate && userCredentialModel != null;
    }
    return false;
  }

  static Future<bool> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to access application',
          options: const AuthenticationOptions(biometricOnly: true));
      return didAuthenticate;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
