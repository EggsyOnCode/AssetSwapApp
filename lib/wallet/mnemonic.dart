import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:xen_wallet/screens/home.dart';
import 'package:xen_wallet/wallet/mnemonic_confirm.dart';
import 'package:xen_wallet/wallet/waller_provider.dart';

class MnemonicPage extends StatelessWidget {
  const MnemonicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    final mnemonic = walletProvider.generateMnemonic();
    final mnemonicWords = mnemonic.split(' ');

    void copyToClipboard() {
      Clipboard.setData(ClipboardData(text: mnemonic));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mnemonic Copied to Clipboard')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MnemonicConfirmation(mnemonic: mnemonic,),
        ),
      );
    }

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  child: Stack(
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/images/AssetSwap.svg",
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Please store this mnemonic phrase safely (even though your wallet will be linked to your login account still this seedphrase for recovery):',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                const SizedBox(height: 24.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(
                    mnemonicWords.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        '${index + 1}. ${mnemonicWords[index]}',
                        style: const TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton.icon(
                  onPressed: () {
                    copyToClipboard();
                  },
                  icon: const Icon(Icons.copy, color: Colors.white,),
                  label: const Text('Copy to Clipboard', style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(24),
                    textStyle: const TextStyle(fontSize: 20.0),
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
