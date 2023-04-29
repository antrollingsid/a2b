import 'package:flutter/material.dart';

class CustomShip extends StatelessWidget {
  const CustomShip({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.deepPurple, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(
                child: Column(
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Track \n Your Shipping',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Row(
                  children: const [
                    Icon(Icons.gif_box),
                    Text(
                      "Iphone 12",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ],
                )
              ],
            )),
            Container(
              height: 100,
              width: 90,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(12)),
            )
          ]),
        ),
      ),
    );
  }
}
