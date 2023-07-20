import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xen_wallet/components/text_fields.dart';
import 'package:xen_wallet/firebase/GoogleSignInProvider.dart';

import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Stack(
              children: <Widget>[
                SvgPicture.asset(
                  "assets/images/AssetSwap.svg",
                  height: size.height * 0.53,
                  alignment: Alignment.center,
                ),
              ],
            ),
            TextInputField(hint: "Email"),
            TextInputField(hint: "Password"),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(size.width * 0.6),
                  backgroundColor: Color.fromARGB(255, 0, 70, 181)),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.handleGoogleSignUp();
                print("Signed Up!");
              },
              child: Text(
                "Sign Up",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                    child: Divider(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      height: 50,
                    )),
              ),
              Text(
                "OR",
                style: TextStyle(color: Colors.white),
              ),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                    child: Divider(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      height: 50,
                    )),
              ),
            ]),
            Container(
              color: const Color.fromARGB(255, 0, 0, 0),
              margin: EdgeInsets.all(9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          shape: BoxShape.circle,
                          color: Colors.white),
                      child: SvgPicture.asset(
                        "assets/images/google.svg",
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      child: SvgPicture.asset(
                        "assets/images/microsoft.svg",
                      ),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
