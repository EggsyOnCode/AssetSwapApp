import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:core';
import 'package:xen_wallet/firebase/GoogleSignInProvider.dart';

import 'package:provider/provider.dart';
import 'package:xen_wallet/wallet/waller_provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      color: Color.fromARGB(255, 0, 0, 0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              SvgPicture.asset(
                "assets/images/AssetSwap.svg",
                alignment: Alignment.center,
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(size.width * 0.6),
                backgroundColor: Color.fromARGB(255, 0, 70, 181)),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(size.width * 0.6),
                backgroundColor: Color.fromARGB(255, 0, 70, 181)),
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: Text(
              "Sign Up",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(size.width * 0.6),
                backgroundColor: Color.fromARGB(255, 0, 70, 181)),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
            child: Text(
              "Log Out",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ));
  }
}
