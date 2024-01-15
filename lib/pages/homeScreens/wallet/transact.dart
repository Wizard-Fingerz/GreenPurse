import 'package:flutter/material.dart';
import 'package:greenpurse/pages/homeScreens/wallet/pay_via_bank.dart';
import 'package:greenpurse/pages/homeScreens/wallet/pay_via_green_purse.dart';
import 'package:greenpurse/pages/homeScreens/wallet/pay_via_phone_number.dart';
import 'package:greenpurse/pages/homeScreens/wallet/scan_to_pay.dart';
import 'package:greenpurse/utils/colors.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            transactionButtons(Image.asset("assets/wallet_image.png"),
                "Pay via Green Purse", "Send to a Green Purse account", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PayViaGreenPurse(),
                ),
              );
            }),
            transactionButtons(Image.asset("assets/bag_eur.png"),
                "Pay via Bank Account", "Send to a bank account", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PayViaBank(),
                ),
              );
            }),
            transactionButtons(
                Image.asset(
                  "assets/phone.png",
                  width: 60,
                ),
                "Pay via Phone Number",
                "Send to a phone number", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PayViaPhoneNumber(),
                ),
              );
            }),
            transactionButtons(
                Image.asset(
                  "assets/scan.png",
                  width: 60,
                ),
                "Scan to Pay",
                "Scan QR code to make transfer", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScanToPay(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget transactionButtons(image, title, subtitle, onPressed) {
    return Column(
      children: [
        ListTile(
          onTap: onPressed,
          leading: image,
          title: Text(title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
          contentPadding: const EdgeInsets.all(5),
          subtitle: Text(subtitle,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.grey,
              )),
          trailing: IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
