import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomReview extends StatelessWidget {
  const CustomReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 333,
        height: 160,
        decoration: BoxDecoration(
            color: context.cardColor, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Alex Cooper",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 40,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 148, 29, 163),
                      ),
                    ),
                    Expanded(child: Container()),
                    const Text(
                      "2 days",
                      style: TextStyle(fontSize: 10, color: Colors.white54),
                    ),
                  ],
                ),
              ),
              const Expanded(
                  child: Text(
                "en an unknown printer too ",
                style: TextStyle(color: Colors.white70),
              ))
            ],
          ),
        ));
  }
}
