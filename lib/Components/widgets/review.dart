import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomReview extends StatefulWidget {
  final String id;

  const CustomReview({Key? key, required this.id}) : super(key: key);

  @override
  State<CustomReview> createState() => _CustomReviewState();
}

class _CustomReviewState extends State<CustomReview> {
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  late String userName;
  @override
  void initState() {
    super.initState();
    fetchUserName(); // Fetch the userName when the state is initialized
  }

  void fetchUserName() async {
    final userDoc = await usersCollection.doc().get();
    setState(() {
      userName = userDoc['details']['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('userToCourierRates')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No data available');
        } else {
          final documents = snapshot.data!.docs;

          final filteredDocuments = documents.where((doc) {
            final data = doc.data();
            print(data['courier']);
            print('\n${widget.id}');
            return data['courier'] == widget.id;
          }).toList();

          if (filteredDocuments.isEmpty) {
            return const Text('No matching documents');
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredDocuments.length,
            itemBuilder: (context, index) {
              final data = filteredDocuments[index].data();
              return SizedBox(
                width: 333,
                height: 120,
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
                              child: Image.network(
                                data['ratedByPhoto'] ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              data['ratedByName'] ?? '',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: context.primaryColor,
                                  size: 15,
                                ),
                                Text(
                                  data['rate'] ?? '',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: context.primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          data['comment'] ?? '',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
