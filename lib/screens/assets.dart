import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:xen_wallet/components/ScrollingCards.dart';

class Assets extends StatefulWidget {
  const Assets({super.key});

  @override
  State<Assets> createState() => AssetsState();
}

class AssetsState extends State<Assets> {
  List<Color> colorList = [
    Color.fromARGB(255, 255, 255, 255), // White
    Color.fromARGB(255, 128, 128, 128), // Grey
    Color.fromARGB(255, 255, 215, 0), // Gold
    Color.fromARGB(255, 139, 0, 0), // Deep Red
    Color.fromARGB(255, 0, 128, 0), // Emerald Green
    Color.fromARGB(255, 245, 245, 220), // Beige
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
            index: 1,
            animationDuration: Duration(milliseconds: 200),
            height: 57,
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            color: Color.fromRGBO(10, 35, 81, 1),
            onTap: (value) {
              switch (value) {
                case 0:
                  Future.delayed(Duration(milliseconds: 200), () {
                    Navigator.pushNamed(context, '/trades');
                  });

                  break;
                case 1:
                  Future.delayed(Duration(milliseconds: 200), () {
                    Navigator.pushNamed(context, '/assets');
                  });
                  break;
                case 2:
                  Future.delayed(Duration(milliseconds: 200), () {
                    Navigator.pushNamed(context, '/main');
                  });
                  break;
                case 3:
                  Future.delayed(Duration(milliseconds: 200), () {
                    Navigator.pushNamed(context, '/wallet');
                  });
                  break;
                case 4:
                  Future.delayed(Duration(milliseconds: 200), () {
                    Navigator.pushNamed(context, '/settings');
                  });
                  break;
                default:
                  Future.delayed(Duration(milliseconds: 200), () {
                    Navigator.pushNamed(context, '/main');
                  });
              }
            },
            items: [
              Icon(
                Icons.article,
                color: Colors.white,
              ),
              Icon(
                Icons.photo_size_select_actual_rounded,
                color: Colors.white,
              ),
              Icon(
                Icons.home_filled,
                color: Colors.white,
              ),
              Icon(
                Icons.wallet_rounded,
                color: Colors.white,
              ),
              Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ]),
        body: SingleChildScrollView(
          child: Container(
              color: Color.fromARGB(255, 0, 0, 0),
              height: size.height,
              width: size.width,
              child: Column(children: [
          SizedBox(
            height: size.height * 0.06,
          ),
          Text(
            "My NFTs/Assets",
            style: TextStyle(
                fontSize: 30, color: const Color.fromARGB(255, 255, 255, 255)),
          ),
              
            //we need Dynamic data here
            ScrollingCards(
              scrollDirection: Axis.vertical,
              width_card: size.width * 0.8,
              height: size.height * 0.8,
              height_card: size.height * 0.25,
              margins: const EdgeInsets.only(bottom: 10),
              colorList: colorList),
              ]),
            ),
        ));
  }
}
