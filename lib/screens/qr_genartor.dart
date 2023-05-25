import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGenerator extends StatelessWidget {
  final double packageid;
  final DateTime deliverydate;
  final String senderid;
  final String packagename;
  final String courrierid;
  final String packagetype;
  final String pickupaddress;
  final String packageweight;

  const QRCodeGenerator(
      {super.key,
      required this.packageid,
      required this.deliverydate,
      required this.senderid,
      required this.packagename,
      required this.courrierid,
      required this.packagetype,
      required this.pickupaddress,
      required this.packageweight});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: QrImageView(
          data: 'Date: $deliverydate \n'
              'Courier Id: $courrierid'
              'Sender Id: $senderid'
              'Package Id: $packageid'
              'Package Name: $packagename'
              'Package Type: $packagetype'
              'Package Weight: $packageweight'
              'Pickup address: $pickupaddress',
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
