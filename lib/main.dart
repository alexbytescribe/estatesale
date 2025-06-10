import 'package:flutter/material.dart';
import 'estate_estimator.dart';

void main() {
  runApp(const EstateSaleApp());
}

class EstateSaleApp extends StatelessWidget {
  const EstateSaleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Estate Sale',
      home: EstimatorPage(),
    );
  }
}
