import 'package:flutter/material.dart';

//not working as of yet

class DynamicTabBar extends StatefulWidget {
  final List<Icon> icons;
  final List<String> labels;
  final double? width;
  final double height;

  DynamicTabBar({required this.icons, required this.labels, required this.height, this.width});

  @override
  _DynamicTabBarState createState() => _DynamicTabBarState();
}

class _DynamicTabBarState extends State<DynamicTabBar> {
  int _currentPageIndex = 0;

  void _onButtonPressed(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        height: widget.height,
        width: widget.width,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                widget.icons.length,
                (index) => ElevatedButton.icon(
                  onPressed: () => _onButtonPressed(index),
                  icon: widget.icons[index],
                  label: Text(widget.labels[index]),
                ),
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: _currentPageIndex,
                children: List.generate(
                  widget.labels.length,
                  (index) => Center(
                    child: Text(
                      'Page ${index + 1} Content',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
