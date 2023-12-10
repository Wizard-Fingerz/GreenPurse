import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:greenpurse/pages/homeScreens/product_details.dart';
import 'package:greenpurse/utils/colors.dart';

class ProductCard extends StatefulWidget {
  final String imageUrl;
  final String productName;
  final String productDescription;
  final String productPriceAndQuantity;
  final String productPrice;

  const ProductCard({
    required this.imageUrl,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    Key? key,
    required this.productPriceAndQuantity,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isAddedToCart = false;

  void addToCart() {
    setState(() {
      // Create a product details object and add to cart
      print('added product');
      ProductDetails product = ProductDetails(
        imageUrl: widget.imageUrl,
        productName: widget.productName,
        productPriceAndQuantity: widget.productPriceAndQuantity,
        productPrice: widget.productPrice,
        productDescription: widget.productDescription,
        quantity: 1,
      );

      Cart.items.add(product);
      isAddedToCart = true;
    });
  }

  void removeFromCart() {
    setState(() {
      // Create a product details object and remove from cart
      ProductDetails product = ProductDetails(
        imageUrl: widget.imageUrl,
        productName: widget.productName,
        productPriceAndQuantity: widget.productPriceAndQuantity,
        productPrice: widget.productPrice,
        productDescription: widget.productDescription,
        quantity: 1,
      );

      Cart.items.remove(product);
      isAddedToCart = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              imageUrl: widget.imageUrl,
              productName: widget.productName,
              productPriceAndQuantity: widget.productPriceAndQuantity,
              productPrice: widget.productPrice,
              productDescription: widget.productDescription,
              quantity: 1,
            ),
          ),
        );
      },
      onDoubleTap: () {},
      child: Card(
        margin: EdgeInsets.all(10),
        color: AppColors.whitish,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.productName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          widget.productPriceAndQuantity,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.red,
                          ),
                        ),
                      ],
                    ),
                    IconButton.filled(
                      onPressed: () {
                        if (isAddedToCart) {
                          // Remove from cart
                          removeFromCart();
                        } else {
                          // Add to cart
                          addToCart();
                        }

                        // Toggle the button state
                        isAddedToCart = !isAddedToCart;
                      },
                      icon: Icon(
                        isAddedToCart ? Icons.remove : Icons.add,
                        color: isAddedToCart ? Colors.red : null,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
