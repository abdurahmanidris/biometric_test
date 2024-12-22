import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'package:test_app/home.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum SupportState {
  unKnown,
  supported,
  unSupported,
}

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unKnown;
  List<BiometricType>? availableBiometrics;

  @override
  void initState() {
    auth.isDeviceSupported().then((bool isSupported) => setState(() =>
        supportState =
            isSupported ? SupportState.supported : SupportState.unSupported));
    super.initState();
    checkBiometric();
    getAvailableBiometrics();
  }

  Future<void> checkBiometric() async {
    late bool canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
      print("Biometric supported: $canCheckBiometric");
    } on PlatformException catch (e) {
      print(e);
      canCheckBiometric = false;
    }
  }

  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> biometricTypes;
    try {
      biometricTypes = await auth.getAvailableBiometrics();
      print("Supported biometrics: $biometricTypes");
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) {
      return;
    }
    setState(() {
      availableBiometrics = biometricTypes;
    });
  }

  Future<void> authenticateWithBiometrics() async {
    try {
      final isAuthenticated = await auth.authenticate(
        localizedReason: "Scan your fingerprint",
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (!mounted) {
        return;
      }

      if (isAuthenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      }
    } on PlatformException catch (e) {
      print(e);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Biometric Authentication"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                supportState == SupportState.supported
                    ? 'Biometric authentication is supported on this device'
                    : supportState == SupportState.unSupported
                        ? 'Biometric authentication is not supported on this device'
                        : 'Checking Biometric support...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: supportState == SupportState.supported
                      ? Colors.green
                      : supportState == SupportState.unSupported
                          ? Colors.red
                          : Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Text('Supported biometrics: $availableBiometrics'),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  onPressed: authenticateWithBiometrics,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.fingerprint,
                        color: Colors.yellowAccent,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Authenticate',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:test_app/home.dart';

class FaceFingerPrintAuth extends StatefulWidget {
  const FaceFingerPrintAuth({super.key});

  @override
  State<FaceFingerPrintAuth> createState() => _FaceFingerPrintAuthState();
}

class _FaceFingerPrintAuthState extends State<FaceFingerPrintAuth> {
  late final LocalAuthentication auth;
  bool _supportState = false;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() {
            _supportState = isSupported;
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('Flutter Biometrics Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: authentication,
              child: Text('Authenticate',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> authentication() async {
    try {
      bool isAuthenticated = await auth.authenticate(
        localizedReason: "Scan your fingerprint",
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      print("Authentication Status is: $isAuthenticated");
      if (isAuthenticated) {
        // Navigate to the Home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      }
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) {
      return;
    }
  }
}*/
