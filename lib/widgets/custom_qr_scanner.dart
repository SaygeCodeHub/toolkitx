import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../configs/app_color.dart';

typedef CreatedForStringCallBack = Function(String qrCode);

class CustomQRCodeScanner extends StatefulWidget {
  const CustomQRCodeScanner(
      {Key? key, this.onPressed, required this.onCaptured})
      : super(key: key);
  final Function()? onPressed;
  final CreatedForStringCallBack onCaptured;

  @override
  State<CustomQRCodeScanner> createState() => _CustomQRCodeScannerState();
}

class _CustomQRCodeScannerState extends State<CustomQRCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String result = '';
  Barcode? qrCode;
  QRViewController? qRController;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qRController!.pauseCamera();
    } else if (Platform.isIOS) {
      qRController!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                  borderColor: AppColor.blueGrey,
                  borderRadius: kQRBorderRadius,
                  borderLength: kQRBorderLength,
                  borderWidth: kQRBorderWidth),
            ),
          ),
          Expanded(
            flex: 1,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('${StringConstants.kFetchedCode} $result'),
              const SizedBox(height: xxTinierSpacing),
              Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: xxLargeSpacing),
                child: PrimaryButton(
                    onPressed: widget.onPressed ??
                        () {
                          Navigator.pop(context, result);
                        },
                    textValue: StringConstants.kCapture),
              ))
            ]),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    qRController = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code.toString();
        widget.onCaptured(result);
      });
    });
  }

  @override
  void dispose() {
    qRController?.dispose();
    super.dispose();
  }
}
