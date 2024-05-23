import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:greenpurse/data/product_data.dart';
import 'package:greenpurse/pages/homeScreens/orderSummary/presentation/order_summary.dart';
import 'package:greenpurse/pages/homeScreens/product_details.dart';
import 'package:greenpurse/pages/widgets/product.dart';
import 'package:greenpurse/utils/colors.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Cart",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Item Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  )),
              Cart.items.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: const Center(
                          child: Text(
                        'Your Cart is Empty',
                        style: TextStyle(color: Colors.red),
                      )))
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ListView.builder(
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
                                        Text(product.quantity.toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            )),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.edit)),
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
                    ),
              const Text("Before you Checkout",
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
              ListTile(
                  leading: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.cancel)),
                  title: const Text("APPLY COUPON",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                  contentPadding: const EdgeInsets.all(0),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios))),
              const Divider(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Item Total",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                  Text("NGN2,400",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Discount",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                  Text("NGN400",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Delivery Fee",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.green,
                      )),
                  Text("Free",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.green,
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Grand Total",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      )),
                  Text("2,200",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ))
                ],
              ),
              ListTile(
                leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(
                      Icons.house_outlined,
                      color: AppColors.white,
                    )),
                title: const Text("Delivering to Home",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                subtitle:
                    const Text("4517 Washington Ave, Manchester....",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        )),
                trailing: TextButton(
                    child: const Text("Change",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )),
                    onPressed: () {}),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderSummary(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                      minimumSize: const Size(300, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text("Checkout (NGN2,200)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
