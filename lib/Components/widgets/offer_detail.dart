import 'package:flutter/material.dart';

class OfferDetail extends StatelessWidget {
  const OfferDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white10, borderRadius: BorderRadius.circular(10)),
        child: Column(children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 100,
                  height: 115,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 51, 122, 88),
                      borderRadius: BorderRadius.circular(20)),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Adam Smith",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 241, 241, 241)),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Courier",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 241, 241, 241)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Colors.purple,
                      height: 50,
                      width: 120,
                    ),
                    Container(
                      color: Colors.purple,
                      height: 50,
                      width: 120,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "200 Tl",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "200 Tl",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "200 Tl",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
