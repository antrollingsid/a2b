import 'package:flutter/material.dart';

import 'colors.dart';

class SearchBarTrackNo extends StatelessWidget {
  const SearchBarTrackNo({
    Key? key,
  }) : super(key: key);

  @override
  //SEARCHBAR
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for something',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.camera_alt),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(9.0)),
        ),
        fillColor: AppColors.onBackgroundDark,
      ),
    );
  }
}
