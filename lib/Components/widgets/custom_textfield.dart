import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield(
      {super.key,
      required this.titleText,
      required this.isPassword,
      required this.hintText});
  final String titleText;

  final bool isPassword;
  final String hintText;
  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                widget.titleText,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            obscureText: widget.isPassword,
            style: const TextStyle(color: Colors.white54),
            decoration: InputDecoration(
              hintStyle:
                  const TextStyle(color: Color.fromARGB(66, 247, 247, 247)),
              contentPadding: const EdgeInsets.all(10.0),
              border: myinputborder(), //normal border
              enabledBorder: myinputborder(), //enabled border
              focusedBorder: myfocusborder(), //focused border
              // set more border style like disabledBorder
              hintText: widget.hintText,
            ),
          ),
        ],
      ),
    );
  }
}

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return const OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(
        color: Colors.white60,
        width: 2,
      ));
}

OutlineInputBorder myfocusborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(
        color: Colors.white,
        width: 2,
      ));
}
