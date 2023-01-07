import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerQRFViewScreen extends StatefulWidget {
  const ScannerQRFViewScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScannerQRFViewScreenState();
}

class _ScannerQRFViewScreenState extends State<ScannerQRFViewScreen> {
  Barcode? result;
  bool isInitCam = false;
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool hasData = false;
  int veces = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, 'back'),
                child: Icon(Icons.backspace_outlined))
          ],
        ),
        body: Center(child: _buildQrView(context)));
  }

  Widget _buildQrView(BuildContext context) {
    double scanArea = 400;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.blue,
          borderRadius: 100,
          borderLength: 100,
          borderWidth: 20,
          cutOutSize: scanArea),
      onPermissionSet: (QRViewController controller, bool hasPermission) =>
          _onPermissionSet(context, controller, hasPermission),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      controller.resumeCamera();
    });
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        navigateReturn(scanData.code!);
      }
    });
  }

  void navigateReturn(String code) {
    if (!hasData) {
      Navigator.pop(context, code);
      hasData = true;
    }
  }

  void _onPermissionSet(
      BuildContext context, QRViewController controller, bool hasPermissions) {
    if (!hasPermissions) {
      print('Sin premisos de cámara');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
