import 'package:flutter/material.dart';

class CoverImageDetails extends StatelessWidget {
  const CoverImageDetails({
    super.key,
    required this.data,
  });

  final Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      color: Colors.grey,
      child: Image.network(
        data!['details']['photoURL'],
        fit: BoxFit.cover,
      ),
    );
  }
}
