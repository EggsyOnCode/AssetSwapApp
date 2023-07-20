import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:hex/hex.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';

abstract class WalletProviderService {
  String generateMnemonic();
  Future<String> getPrivateKey(String menmonic);
  Future<EthereumAddress> getPublicKey(String privatekey);
}

class WalletProvider extends ChangeNotifier implements WalletProviderService {
  String? privatekey;
  EthereumAddress? address;

//loads privatekey from mem and assigns privatekey that value
  Future<void> loadPrivatekey() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    privatekey = pref.getString('privatekey');
  }
//stores privatekey vlaue into the shared pref
  Future<void> storePrivatekey(String privatekey) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('privatekey', privatekey);
    this.privatekey = privatekey;
    notifyListeners();
  }


  Future<void> storeAddress(EthereumAddress publicAddress) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('address', address.toString());
    this.address = address;
    notifyListeners();
  }
  Future<void> loadAddress() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    privatekey = pref.getString('address');
  }



  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  @override
  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    privatekey = HEX.encode(master.key);
    return privatekey!;
  }

  @override
  Future<EthereumAddress> getPublicKey(String privatekey) async {
    final private = EthPrivateKey.fromHex(privatekey);
    final address = await private.address;
    return address;
  }
}
