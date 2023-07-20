import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:xen_wallet/wallet/wallet_home.dart';

class SendTokensPage extends StatefulWidget {
  final String privateKey;
  final String publicAddress;
  const SendTokensPage(
      {super.key, required this.privateKey, required this.publicAddress});

  @override
  State<SendTokensPage> createState() => _SendTokensPageState();
}

class _SendTokensPageState extends State<SendTokensPage> {
  String recipientAddress = '';
  String amtSent = '';
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16.0),
        color: Colors.black,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: recipientController,
                onChanged: (value) {
                  setState(() {
                    recipientAddress = value;
                  });
                },
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Recipient Address',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 25),
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 84, 78,
                          78), // Set the white color for the border
                      width: 2.0, // Set the width of the border
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10)), // Set the border radius
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: amountController,
                onChanged: (value) {
                  setState(() {
                    amtSent = value;
                  });
                },
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 25),
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 84, 78,
                          78), // Set the white color for the border
                      width: 2.0, // Set the width of the border
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10)), // Set the border radius
                  ),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String recipient = recipientController.text;
                  double amount = double.parse(amountController.text);
                  BigInt bigIntValue = BigInt.from(amount * pow(10, 18));
                  print(bigIntValue);
                  EtherAmount ethAmount =
                      EtherAmount.fromBigInt(EtherUnit.wei, bigIntValue);
                  print(ethAmount);
                  // Convert the amount to EtherAmount
                  sendTransaction(recipient, ethAmount);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Eth Sent')),
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WalletHome(
                                privatekey: widget.privateKey,
                                publicAddress: widget.publicAddress,
                                recipientAddress: recipientAddress,
                                amtSent: amtSent,
                              )));
                },
                child: const Text('Send'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendTransaction(String receiver, EtherAmount txValue) async {
    var apiUrl =
        "https://eth-goerli.g.alchemy.com/v2/bP7U4Z7H7v1qMXSfdyQYR-odhgb5Sa6N"; // Replace with your API
    // Replace with your API
    var httpClient = http.Client();
    var ethClient = Web3Client(apiUrl, httpClient);

    EthPrivateKey credentials = EthPrivateKey.fromHex('0x' + widget.privateKey);

    EtherAmount etherAmount = await ethClient.getBalance(credentials.address);
    EtherAmount gasPrice = await ethClient.getGasPrice();

    print(etherAmount);

    await ethClient.sendTransaction(
      credentials,
      Transaction(
        to: EthereumAddress.fromHex(receiver),
        gasPrice: gasPrice,
        maxGas: 100000,
        value: txValue,
      ),
      chainId: 5,
    );
  }
}
