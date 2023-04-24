import 'package:flutter/material.dart';

import '../../Components/widgets/custom_textfield_gradiant.dart';

class TrackShippement extends StatelessWidget {
  const TrackShippement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black ,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purpleAccent,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: const BoxDecoration(
                color: Colors.purpleAccent,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Hello, ',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'John Doe',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.tealAccent)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const SizedBox(
                    width: 150,
                    child: Text(
                      "Track your shippement",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const GradiantTextfield(
                    hintText: 'Text',
                    titleText: '',
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
