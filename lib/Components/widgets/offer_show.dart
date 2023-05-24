import 'package:flutter/material.dart';

class OfferView extends StatelessWidget {
  const OfferView({
    super.key,
    required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 333,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white10, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            color: Colors.purpleAccent,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(253, 239, 239, 239)),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            width: 30,
                            height: 16,
                            color: Colors.purple,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 30,
                            height: 16,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            width: 30,
                            height: 16,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            width: 30,
                            height: 16,
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 23,
                  child: Center(
                      child: Icon(
                    Icons.arrow_forward_sharp,
                    color: Colors.white70,
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
