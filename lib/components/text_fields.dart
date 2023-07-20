import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  final String hint;

  const TextInputField({Key? key, required this.hint}) : super(key: key);

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool isHidden = false;

  @override
  void initState() {
    isHidden = false;
    super.initState();
  }

  @override
  void dispose() {
    isHidden = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 0, 12, 142),
            borderRadius: BorderRadius.circular(29)),
        child: TextField(
          decoration: InputDecoration(
              icon:
                  widget.hint == "Email" ? Icon(Icons.email) : Icon(Icons.lock),
              iconColor: Colors.white,
              hintStyle: TextStyle(color: Colors.white),
              hintText: widget.hint,
              border: InputBorder.none,
              suffixIcon: widget.hint == "Email"
                  ? null
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          isHidden = !isHidden;
                        });
                      },
                      icon: Icon(Icons.visibility_off))),
          obscureText: widget.hint == "Password" ? isHidden : false,
        ));
  }
}
