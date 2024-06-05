import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

class NFCReadingScreen extends StatelessWidget {
  const NFCReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: 'NFC Reader'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
            onPressed: () async {
              try {
                // # check if NFC is available on the device or not.
                bool isAvailable = await NfcManager.instance.isAvailable();
                // # If NFC is available, start a session to listen for NFC tags.
                if (isAvailable) {
                  showCustomSnackBar(context, 'NFC is Available', '');
                  NfcManager.instance.startSession(
                      onDiscovered: (NfcTag tag) async {
                    try {
                      showCustomSnackBar(context, 'Starting Session', '');
                      // # When an NFC tag is discovered, we check if it supports NDEF technology.
                      NdefMessage message =
                          NdefMessage([NdefRecord.createText('Hello, NFC!')]);
                      showCustomSnackBar(context, message.toString(), '');
                      await Ndef.from(tag)?.write(
                          message); //If it supports NDEF, create an NDEF message and write it to the tag.
                      debugPrint('Data emitted successfully');
                      showCustomSnackBar(
                          context, 'Data emitted successfully', '');
                      Uint8List payload = message.records.first.payload;
                      String text = String.fromCharCodes(payload);
                      showCustomSnackBar(context, 'Written data: $text', '');
                      debugPrint("Written data: $text");

                      // #stop the NFC Session
                      NfcManager.instance.stopSession();
                    } catch (e) {
                      debugPrint('Error emitting NFC data: $e');
                      showCustomSnackBar(
                          context, 'Error emitting NFC data: $e', '');
                    }
                  });
                } else {
                  debugPrint('NFC not available.');
                  showCustomSnackBar(context, 'NFC not available.', '');
                }
              } catch (e) {
                debugPrint('Error writing to NFC: $e');
                showCustomSnackBar(context, 'Error writing to NFC: $e', '');
              }
            },
            child: const Text('Start NFC Reading'),
          ),
        ),
      ),
    );
  }
}
