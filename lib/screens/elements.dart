import 'package:flutter/material.dart';

import 'colors.dart';

class SearchBarTrackNo extends StatelessWidget {
  const SearchBarTrackNo({
    Key? key,
  }) : super(key: key);

  @override
  //SEARCHBAR
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for something',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: const Icon(Icons.camera_alt),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(9.0)),
          ),
          fillColor: AppColors.buttonBlue,
        ),
      ),
    );
  }
}

class backBtn extends StatelessWidget {
  const backBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: AppColors.buttonStroke,
          ),
          borderRadius: BorderRadius.circular(35),
        ),
        child: IconButton(
          // iconSize: ,
          padding: const EdgeInsets.fromLTRB(7, 3, 0, 3),
          icon: Icon(Icons.adaptive.arrow_back, size: 18.0),
          color: AppColors.onBackgroundDark,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class menuBtn extends StatelessWidget {
  const menuBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: AppColors.buttonStroke,
          ),
          borderRadius: BorderRadius.circular(35),
        ),
        child: IconButton(
          // iconSize: ,
          padding: const EdgeInsets.fromLTRB(7, 3, 0, 3),
          icon: Icon(Icons.adaptive.more, size: 18.0),
          color: AppColors.onBackgroundDark,
          onPressed: () {
            // Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
