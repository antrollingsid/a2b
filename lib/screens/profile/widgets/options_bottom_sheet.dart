import 'package:flutter/material.dart';

import '../../../../common/bordered_button.dart';

class MoreActionsBottomSheet extends StatelessWidget {
  const MoreActionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 4,
                width: 50,
                color: Colors.grey.shade200,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    leading: CustomBorderedButton(
                      icon: Icons.notifications_off,
                      onPressed: () {},
                    ),
                    title: const Text("Mute"),
                  ),
                  ListTile(
                    leading: CustomBorderedButton(
                      icon: Icons.block,
                      onPressed: () {},
                    ),
                    title: const Text("Block"),
                  ),
                  ListTile(
                    leading: CustomBorderedButton(
                      icon: Icons.archive,
                      onPressed: () {},
                    ),
                    title: const Text("UnFollow"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
