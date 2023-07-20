//the purpose of this is to ensure that the mnemonic has been correctly copied by the user and hopegully stored in a secure place
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';
import 'package:xen_wallet/wallet/waller_provider.dart';
import 'package:xen_wallet/wallet/wallet_home.dart';

class MnemonicConfirmation extends StatefulWidget {
  final String mnemonic;
  const MnemonicConfirmation({super.key, required this.mnemonic});

  @override
  State<MnemonicConfirmation> createState() => _MnemonicConfirmationState();
}

class _MnemonicConfirmationState extends State<MnemonicConfirmation> {
  bool isVerified = false;
  String privatekey = '';
  String publicAdress = '';
  String verificationText = '';

  void successVerificationMsg() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Correct Seed')),
    );
  }

  void failVerificationMsg() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Incorrect Seed!!!')),
    );
  }

  void verifyMnemonic() {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);

    if (verificationText.trim() == widget.mnemonic.trim()) {
      walletProvider.getPrivateKey(widget.mnemonic).then((privateKey) {
        setState(() {
          isVerified = true;
          successVerificationMsg();
        });
      });
    } else {
      isVerified = false;
      failVerificationMsg();
    }
  }


  @override
  Widget build(BuildContext context) {
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
              Text("Confirm Mnemonic Phrase",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 40)),
              const SizedBox(
                height: 30,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    verificationText = value;
                  });
                },
                keyboardType: TextInputType.multiline,
                style: TextStyle(color: Colors.white),
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Paste the Seed phrase: ",
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
                    verifyMnemonic();
                  },
                  child: const Text('Verify', style: TextStyle(fontSize: 30)),
                ),
              ),
              const SizedBox(height: 55.0),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 14, 58, 152),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: isVerified
                      ? () async {
                          final walletprovider = WalletProvider();
                          final pvkey =
                              await walletprovider.getPrivateKey(widget.mnemonic);
                          privatekey = pvkey;
                          print(pvkey);
                          await walletprovider.storePrivatekey(pvkey);
                          final addr = await walletprovider.getPublicKey(pvkey);
                          await walletprovider.storeAddress(addr);
                          publicAdress = addr.toString();
                          print(addr);
          
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WalletHome(privatekey: privatekey, publicAddress: publicAdress)),
                          );
                        }
                      : null,
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
