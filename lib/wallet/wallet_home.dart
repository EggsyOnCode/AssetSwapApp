import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';
import 'package:xen_wallet/wallet/send_tokens.dart';
import 'package:xen_wallet/wallet/waller_provider.dart';

import '../utils/get_balance.dart';

class WalletHome extends StatefulWidget {
  final String publicAddress;
  final String privatekey;
  //this following data is coming frm send_tokens page ;
  final String? recipientAddress;
  final String? amtSent;

  const WalletHome(
      {super.key, required this.privatekey, required this.publicAddress, this.amtSent, this.recipientAddress});

  @override
  State<WalletHome> createState() => _WalletHomeState();
}

class _WalletHomeState extends State<WalletHome> {
  String walletAddress = '';
  String balance = '';
  @override
  void initState() {
    super.initState();
    loadWalletData();
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: walletAddress));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Wallet Address Copied to Clipboard')),
    );
  }

  void copyKeyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.privatekey));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Private Key Copied to Clipboard')),
    );
  }

  Future<void> loadWalletData() async {
    walletAddress = widget.publicAddress.toString();
    String response = await getBalances(widget.publicAddress);
    dynamic data = json.decode(response);
    String newBalance = data['balance'] ?? '0';

    // Transform balance from wei to ether
    EtherAmount latestBalance =
        EtherAmount.fromBigInt(EtherUnit.wei, BigInt.parse(newBalance));
    String latestBalanceInEther =
        latestBalance.getValueInUnit(EtherUnit.ether).toString();

    setState(() {
      balance = latestBalanceInEther.substring(0, 7);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(8),
        color: Color.fromARGB(255, 0, 0, 0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(children: [
            SizedBox(
              height: 25,
            ),
            Text("Your Wallet",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 40)),
            Container(
              width: size.width * 0.7,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      walletAddress,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(color: Colors.white),
                      softWrap: false,
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    child: Icon(
                      Icons.copy,
                    ),
                    onPressed: () {},
                    backgroundColor: const Color.fromARGB(255, 11, 80, 136),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 11, 80, 136),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
            ),
            SizedBox(
              height: 19,
            ),
            Row(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FeatherIcons.dollarSign,
                            size: 50,
                          ),
                          Text("FIAT Balance",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40))
                        ]),
                  ),
                  width: size.width * 0.45,
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(128, 128, 128, 1),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            foregroundColor: Colors.green,
                            radius: 30,
                            child:
                                SvgPicture.asset("assets/images/polygon.svg"),
                          ),
                          Text(balance,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40))
                        ]),
                  ),
                  width: size.width * 0.45,
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(171, 143, 63, 1),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton.extended(
                    heroTag: null,
                    label: Text(
                      "Buy Crypto",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    icon: Icon(
                      Icons.swap_vert_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                  FloatingActionButton.extended(
                    heroTag: null,
                    label: Text(
                      "Withdraw Fiat",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    icon: Icon(
                      Icons.attach_money_sharp,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                  FloatingActionButton.extended(
                    heroTag: null,
                    label: Text(
                      "Send Crypto",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    icon: Icon(
                      Icons.arrow_circle_up_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SendTokensPage(
                                  privateKey: widget.privatekey, publicAddress: widget.publicAddress,)));
                    },
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                  FloatingActionButton.extended(
                    heroTag: null,
                    label: Text(
                      "Refresh",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        loadWalletData();
                      });
                    },
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            FloatingActionButton.extended(
              heroTag: null,
              label: Text(
                "Copy Private Key",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              icon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              onPressed: () {
                copyKeyToClipboard();
              },
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
            ),
            SizedBox(
              height: 5,
            ),
            Text("Activity",
                style: TextStyle(color: Colors.white, fontSize: 30)),
            Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.recipientAddress.toString(),
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 167, 23, 23)
                          ),
                        ),
                        Text(
                          widget.amtSent.toString(),
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 139, 31, 31)
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
