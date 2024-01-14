import 'package:flutter/material.dart';
import 'package:greenpurse/pages/homeScreens/cart_page.dart';
import 'package:greenpurse/utils/colors.dart';

class MarketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/green_purse_logo.png"),
        title: const Text("Explore Market",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            )),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search Product',
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
          ],
        ),
      ),
    );
  }
}
