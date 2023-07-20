import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../components/ScrollingCards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //data Structs:
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
        index: 2,
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
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Container(
                width: size.width,
                height: size.height * 0.35,
                child: Column(children: [
                  Row(
                    children: [
                      //insert user's pic
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              shape: BoxShape.circle,
                              color: Colors.black),
                          child: Icon(
                            Icons.person_2_rounded,
                            size: 48,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      //to create space between the two icons
                      SizedBox(
                        width: size.width * 0.65,
                      ),
                      //display balance in diff formats; eth , usd, etc
                      GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.table_rows_sharp,
                            size: 48,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  //Balance: to be fetched dynamically
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      "Rs.",
                      style: TextStyle(
                          fontSize: 40, color: Color.fromRGBO(255, 191, 0, 1)),
                    ),
                    Text(
                      "45,000",
                      style: TextStyle(
                          fontSize: 63, color: Color.fromRGBO(255, 191, 0, 1)),
                    ),
                  ]),
                ]),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(10, 35, 81, 1),
                    // image: DecorationImage(
                    //     image: AssetImage("assets/images/header-blockc.jpg"),
                    //     fit: BoxFit.cover),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(40),
                    )),
              ),

              SizedBox(
                width: size.width,
                height: size.height * 0.02,
                child: Container(
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Text(
                "Trade History",
                style: TextStyle(
                    fontSize: 30,
                    color: const Color.fromARGB(255, 255, 255, 255)),
              ),
              //Trade History Cards
              ScrollingCards(
                  scrollDirection: Axis.horizontal,
                  height: size.height * 0.3,
                  width_card: size.width * 0.45,
                  height_card: size.height * 0.3,
                  margins: const EdgeInsets.only(right: 10, left: 5),
                  colorList: colorList),

              SizedBox(
                width: size.width,
                height: size.height * 0.02,
                child: Container(
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Text(
                "NFTs Owned",
                style: TextStyle(
                    fontSize: 30,
                    color: const Color.fromARGB(255, 255, 255, 255)),
              ),
              //NFT owned
              ScrollingCards(
                  scrollDirection: Axis.horizontal,
                  height: size.height * 0.3,
                  width_card: size.width * 0.45,
                  height_card: size.height * 0.3,
                  margins: const EdgeInsets.only(right: 10, left: 5),
                  colorList: colorList),

              SizedBox(
                width: size.width,
                height: size.height * 0.02,
                child: Container(
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
