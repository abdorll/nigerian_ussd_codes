import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:ussd_bank_codes/widget/textts.dart';

enum AlertType { failed, success, info }

class Alerts {
  static showAlert(
      {String title = "Info",
      required String subtitle,
      Widget? anotherWidget,
      required AlertType alertType}) {
    return BotToast.showNotification(
        backgroundColor: alertType == AlertType.failed
            ? Colors.red
            : alertType == AlertType.info
                ? Colors.blue
                : Colors.green,
        title: (_) {
          return Row(
            children: [
              TextOf(
                text: title,
                size: 12,
                color: Colors.white,
                weight: FontWeight.w700,
              )
            ],
          );
        },
        subtitle: (_) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextOf(
                text: subtitle,
                size: 11,
                color: Colors.white,
                weight: FontWeight.w500,
              ),
              anotherWidget ?? const SizedBox.shrink()
            ],
          );
        },
        duration: const Duration(seconds: 2),
        trailing: (_) {
          return InkWell(
              onTap: () {
                BotToast.cleanAll();
              },
              child: const Icon(
                Icons.cancel_outlined,
                size: 30,
                color: Colors.white,
              )
              // IconOf(Icons.cancel_outlined, 30, Colors.white)
              );
        });
  }
}
//AllAlerts.info(title: 'title', subtitle: subtitle);