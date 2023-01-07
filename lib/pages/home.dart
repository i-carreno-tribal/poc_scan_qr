import 'package:flutter/material.dart';
import 'package:poc_scan_qr/pages/scanner_qr_view_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String qrValue = '';

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner QR POC '),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () async {
                final String? qr = await _navigateAndDisplaySelection(context);

                if (qr != null) {
                  setState(() {
                    qrValue = qr;
                  });
                }
              },
              child: const Text('Open QR Scanner POC')),
          Center(
            child: Text(
              qrValue,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}

Future<dynamic> _navigateAndDisplaySelection(BuildContext context) async {
  // Navigator.push returns a Future that completes after calling
  // Navigator.pop on the Selection Screen.
  final result = await Navigator.push(
    context,
    // Create the SelectionScreen in the next step.
    MaterialPageRoute(builder: (context) => const ScannerQRFViewScreen()),
  );

  return result;
}
