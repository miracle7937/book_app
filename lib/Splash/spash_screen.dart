// ignore_for_file: deprecated_member_use, prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_new, library_private_types_in_public_api, use_build_context_synchronously, unused_import
import 'package:flutter/material.dart';
import '../Constance/constance.dart';
import '../Constance/theme.dart';
import '../auth/register.dart';
import '../main.dart';
import '../utils/images.dart';
import '../utils/local_storage_data.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 700));
    animationController.forward();
    _loadNextScreen();
    super.initState();
  }

  _loadNextScreen() async {
    await Future.delayed(Duration(milliseconds: 2000));
    LocalDataStorage.getUserData().then((value) {
      if (value == null) {
        Navigator.pushReplacementNamed(context, Routes.INTRODUCTION);
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => RegisterScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                BookImages.logoIcon,
                height: 70,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "SIDE CAMPUS",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      ),
    );
  }
}
