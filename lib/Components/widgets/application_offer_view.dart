import 'package:a2b/main.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main/utils/colors.dart';

class ApplicationOfferView extends StatelessWidget {
  const ApplicationOfferView({
    super.key,
    required this.name,
    required this.photoUrl,
    required this.date,
    required this.transportationType,
    required this.license,
  });
  final String name;
  final String photoUrl;
  final String date;
  final String transportationType;
  final String license;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 333,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(10)),
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
                          GestureDetector(
                            onTap: () {
                              // Implement the logic to show the image in full size
                              // For example, you can use a Dialog or a separate screen to display the image.
                              showDialog(
                                context: context,
                                builder: (_) => Dialog(
                                  child: Image.network(
                                    photoUrl,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            },
                            child: ClipOval(
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(photoUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: context.scaffoldBackgroundColor),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                language.date,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.scaffoldBackgroundColor),
                              ),
                              Text(
                                date,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.scaffoldBackgroundColor),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                language.tranportType,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.scaffoldBackgroundColor),
                              ),
                              Text(
                                transportationType,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.scaffoldBackgroundColor),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                language.addDocument,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context.scaffoldBackgroundColor),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => Dialog(
                                      child: Image.network(
                                        license,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                },
                                child: ClipOval(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(license),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
