import 'package:flutter/material.dart';
import 'services/vision_service.dart';
import 'services/pricing_service.dart';

class EstimatorPage extends StatefulWidget {
  const EstimatorPage({Key? key}) : super(key: key);

  @override
  State<EstimatorPage> createState() => _EstimatorPageState();
}

class _EstimatorPageState extends State<EstimatorPage> {
  final VisionService _vision = VisionService();
  final PricingService _pricing = PricingService();

  String? _description;
  double? _price;
  double? _bargain;
  bool _loading = false;

  Future<void> _captureAndEstimate() async {
    setState(() => _loading = true);
    final label = await _vision.identifyFromCamera();
    final price = await _pricing.lookupPrice(label);
    setState(() {
      _description = label;
      _price = price;
      _bargain = price != null ? price * 0.8 : null; // 20% off suggestion
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estate Sale Estimator')),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_description != null) Text('Item: \$_description'),
                  if (_price != null) Text('Estimated Price: \$${_price!.toStringAsFixed(2)}'),
                  if (_bargain != null) Text('Suggested Bargain Price: \$${_bargain!.toStringAsFixed(2)}'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _captureAndEstimate,
                    child: const Text('Capture Item'),
                  ),
                ],
              ),
      ),
    );
  }
}
