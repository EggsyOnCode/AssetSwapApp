import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xen_wallet/utils/get_balance.dart';
import 'package:xen_wallet/wallet/wallet_home.dart';

class WalletImport extends StatefulWidget {
  const WalletImport({super.key});

  @override
  State<WalletImport> createState() => _WalletImportState();
}

class _WalletImportState extends State<WalletImport> {
  String pvkey = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    void verifyPvkey() async {
      var response = await importWallet(pvkey);
      if (response != "false") {
        dynamic data = json.decode(response);
        String address = data['address'] ?? '0x';
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wallet Successfully Imported')));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WalletHome(privatekey: pvkey, publicAddress: address)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect Private Key!')));
      }
    }

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8.0),
        color: Colors.black,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Text("Enter your Account's Private Key",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 30)),
              const SizedBox(
                height: 30,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    pvkey = value;
                  });
                },
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Paste the private key here: ",
                  labelStyle: TextStyle(color: Colors.white, fontSize: 25),
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(
                          255, 84, 78, 78), // Set the white color for the border
                      width: 2.0, // Set the width of the border
                    ),
                    borderRadius:
                        BorderRadius.circular(10.0), // Set the border radius
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    verifyPvkey();
                  },
                  child:
                      const Text('Import Wallet', style: TextStyle(fontSize: 20)),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
