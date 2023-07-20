import 'package:flutter/material.dart';

class ScrollingCards extends StatelessWidget {
  const ScrollingCards({
    super.key,
    required this.width_card,
    required this.height,
    required this.height_card,
    required this.scrollDirection,
    required this.margins,
    required this.colorList,
  });

  final double width_card;
  final double height;
  final double height_card;
  final EdgeInsetsGeometry margins;
  final List<Color> colorList;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: scrollDirection,
        itemBuilder: (context, index) {
          return Container(
            width: width_card,
            height: height_card,
            child: Text(
              "Hello",
              style: TextStyle(color: Colors.amber),
            ),
            decoration: BoxDecoration(
                color: colorList[index % colorList.length],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(25)),
            margin: margins,
          );
        },
        itemCount: colorList.length,
      ),
    );
  }
}
