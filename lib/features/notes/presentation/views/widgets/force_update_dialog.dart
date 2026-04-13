import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpdateDialog {
  static Future<void> show({
    required BuildContext context,
    required String packageName,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              "Update Required",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text(
              "A new version of the app is available. You must update to continue using this app.",
            ),
            actions: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final url = Uri.parse(
                      "https://play.google.com/store/apps/details?id=$packageName",
                    );

                    await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: const Text("Update Now"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}