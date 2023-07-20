import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xen_wallet/wallet/mnemonic.dart';
import 'package:xen_wallet/wallet/wallet_import.dart';

class WalletGenerate extends StatelessWidget {
  const WalletGenerate({super.key});

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
              SizedBox(
                height: 400,
                child: Stack(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/images/AssetSwap.svg",
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
                child: SvgPicture.asset(
                  "assets/images/cryptowallet.svg",
                  alignment: Alignment.center,
                  colorFilter: ColorFilter.srgbToLinearGamma(),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MnemonicPage()));
                  },
                  child: Text(
                    "Generate Wallet",
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  )),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WalletImport()));
                  },
                  child: Text(
                    "Import Wallet",
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ))
            ]),
      ),
    );
  }
}
