import 'package:flutter/material.dart';
import 'package:greenpurse/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  const CategoryCard({super.key, required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(200),
          ),
          child: Container(
              width: 73,
              height: 73,
              padding: const EdgeInsets.all(20),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: AppColors.whitish),
              child: ClipOval(
                child: CachedNetworkImage(
                  width: 20,
                  height: 20,
                  imageUrl: imageUrl,
                  errorWidget: (context, url, error) => const Icon(
                      Icons.error), // Error widget if image fails to load
                  fit: BoxFit
                      .cover, // You can adjust the fit property based on your requirement
                ),
              )),
        ),
        Text(name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ))
      ],
    );
  }
}
