import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:greenpurse/utils/colors.dart';

class Cart {
  static List<ProductDetails> items = [];
}

class ProductDetails extends StatefulWidget {
  int quantity;
  final String imageUrl;
  final String productName;
  final String productDescription;
  final String productPriceAndQuantity;
  final String productPrice;
  ProductDetails(
      {super.key,
      required this.imageUrl,
      required this.productName,
      required this.productDescription,
      required this.productPrice,
      required this.productPriceAndQuantity,
      this.quantity = 1});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isAddedToCart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: MyCustomClipper(),
                child: CachedNetworkImage(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width,
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.cover, // Adjust the BoxFit as needed
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppBar(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back_ios, size: 15),
                            ),
                          ),
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.search)))),
                        )
                      ]),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset("assets/online_store.png"))
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.productName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        )),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (widget.quantity > 0) {
                                widget.quantity--;
                              }
                            });
                          },
                          icon: const Icon(Icons.remove),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.whitish),
                          ),
                        ),
                        Text(widget.quantity.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            )),
                        IconButton.filled(
                            onPressed: () {
                              setState(() {
                                widget.quantity++;
                              });
                            },
                            icon: const Icon(Icons.add)),
                      ],
                    )
                  ],
                ),
                Text(widget.productPriceAndQuantity,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.red)),
                Text(
                    "Ginger is a flowering plant whose rhizome, ginger root or ginger, is widely used as a spice and a folk medicine.",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey)),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    propertyCard("assets/lotus.png", "Organic", "100"),
                    propertyCard("assets/calendar.png", "Organic", "100"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    propertyCard("assets/favourites.png", "Organic", "100"),
                    propertyCard("assets/matches.png", "Organic", "100"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (isAddedToCart) {
                          // Remove from cart
                          Cart.items.remove(widget);
                        } else {
                          // Add to cart
                          Cart.items.add(widget);
                        }

                        // Toggle the button state
                        isAddedToCart = !isAddedToCart;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                      minimumSize: const Size(500, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      isAddedToCart ? "Remove from Cart" : "Add to Cart",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget propertyCard(String image, title, value) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: AppColors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              image,
              width: 35,
              height: 35,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.green)),
                Text(title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomShapeImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipPath(
          clipper: MyCustomClipper(),
          child: Container(
            height: 200,
            width: double.infinity,
            child: Image.network(
              'https://example.com/your_image.jpg', // Replace with your image URL
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 30,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
