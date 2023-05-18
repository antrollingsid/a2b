import 'package:flutter/material.dart';

import '../place_order_map.dart';
import 'order_details.dart';

class NewOrder extends StatelessWidget {
  const NewOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Text("Product Details"),
              ),
              Tab(icon: Text("Add Order Map ")),
            ],
          ),
          title: const Text('A2B'),
        ),
        body: const TabBarView(
          children: [
            OrderPage(),
            PlaceOrderMap(),
          ],
        ),
      ),
    );
  }
}
