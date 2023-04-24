import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white10, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      color: Colors.purpleAccent,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Alexa Cooper",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(253, 239, 239, 239)),
                    ),
                  ],
                )),
                const SizedBox(
                  width: 23,
                  child: Center(
                      child: Icon(
                    Icons.message_outlined,
                    color: Colors.white60,
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
