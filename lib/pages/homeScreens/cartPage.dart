import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:greenpurse/data/product_data.dart';
import 'package:greenpurse/pages/homeScreens/product_details.dart';
import 'package:greenpurse/pages/widgets/product.dart';
import 'package:greenpurse/utils/colors.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      const TextSpan(
                        text: "Cart",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Image.asset("assets/Basket.png",
                              height: 20, width: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Cart.items.isEmpty
                      ? const Text('Your Cart is Empty')
                      : ListView.builder(
                        itemCount: Cart.items.length,
                        itemBuilder: (context, index) {
                          final product = Cart.items[index];
                      
                          return Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      CachedNetworkImageProvider(
                                          product.imageUrl),
                                ),
                                title: Text(product.productName),
                                subtitle:
                                    Text(product.productPriceAndQuantity),
                                // You can customize the ListTile as needed
                                trailing: Container(
                                    width: 120, // Set the desired width
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (product.quantity > 0) {
                                                product.quantity--;
                                              }
                                            });
                                          },
                                          icon: const Icon(Icons.remove),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    AppColors.whitish),
                                          ),
                                        ),
                                        Text(product.quantity.toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            )),
                                        IconButton.filled(
                                            onPressed: () {
                                              setState(() {
                                                product.quantity++;
                                              });
                                            },
                                            icon: const Icon(Icons.add)),
                                      ],
                                    )),
                              ),
                              Divider(
                                thickness:
                                    0.1, // You can adjust the thickness as needed
                                color: AppColors
                                    .grey, // You can set the color as needed
                              ),
                            ],
                          );
                        },
                      ),
                  Text("Before you Checkout",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      )),
                  SizedBox(
                    height: 265,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        final product = productList[index];
                        return ProductCard(
                          imageUrl: product.imageUrl,
                          productName: product.productName,
                          productPriceAndQuantity:
                              product.productPriceAndQuantity,
                          productPrice: product.productPrice,
                          productDescription: product.productDescription,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
