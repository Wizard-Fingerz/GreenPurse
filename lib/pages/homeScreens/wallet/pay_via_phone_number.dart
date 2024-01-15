import 'package:flutter/material.dart';
import 'package:greenpurse/pages/widgets/user_transaction_container.dart';
import 'package:greenpurse/utils/colors.dart';

class PayViaPhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer via Phone Number',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter Phone Number',
                  hintStyle: TextStyle(color: AppColors.grey),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.grey,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                onChanged: (text) {
                  print('Search text: $text');
                },
              ),
              UserTransactionList(),
            ],
          ),
        ),
      ),
    );
  }
}
