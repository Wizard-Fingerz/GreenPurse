import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:greenpurse/data/category_data.dart';
import 'package:greenpurse/data/product_data.dart';
import 'package:greenpurse/pages/widgets/banner.dart';
import 'package:greenpurse/pages/widgets/category.dart';
import 'package:greenpurse/pages/widgets/product.dart';
import 'package:greenpurse/utils/colors.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: const AssetImage(
                "assets/avatar.png",
              ), // Make sure to replace "name.png" with the actual file name and path
              radius: 20,
              backgroundColor: AppColors.whitish,
            ),
          ),
          backgroundColor: AppColors.white,
          toolbarHeight: 80,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Good morning",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                  )),
              const Text("Amelia Barlow",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ))
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.green,
                      ),
                      const Text("My Address",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                      const Icon(Icons.arrow_drop_down)
                    ],
                  )),
            )
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search Categories',
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
              const SizedBox(
                height: 10,
              ),
              CarouselSlider(
                items: const [
                  BannerCard(),
                  BannerCard(),
                  BannerCard(),
                ],
                options: CarouselOptions(
                  height: 158,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text("Categories",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          )),
                      Image.asset("assets/FaceSavoringFood.png")
                    ],
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text("See all",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )))
                ],
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    final category = categoryList[index];
                    return CategoryCard(
                      imageUrl: category.imageUrl,
                      name: category.name,
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text("Best Selling",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          )),
                      Image.asset("assets/FaceSavoringFood.png")
                    ],
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text("See all",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )))
                ],
              ),
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
                      productPriceAndQuantity: product.productPriceAndQuantity,
                      productPrice: product.productPrice, productDescription: product.productDescription,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
