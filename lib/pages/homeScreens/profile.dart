import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:greenpurse/utils/colors.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("My Profile",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              leading: Stack(
                children: [
                  Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.whitish),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: "",
                          errorWidget: (context, url, error) => const Icon(Icons
                              .error), // Error widget if image fails to load
                          fit: BoxFit
                              .cover, // You can adjust the fit property based on your requirement
                        ),
                      )),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.green),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          size: 10,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              contentPadding: const EdgeInsets.all(5),
              title: const Text(
                "Amelia Barlow",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: const Text(
                "ameliabarlow@gmail.com",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Divider(),
            profileTileButton(
                const Icon(Icons.edit_note), "Edit Profile", () {}),
            profileTileButton(const Icon(Icons.lock), "Change Password", () {}),
            profileTileButton(
                const Icon(Icons.shopping_bag), "My Orders", () {}),
            profileTileButton(
                const Icon(Icons.security), "Privacy Policy", () {}),
            profileTileButton(
                const Icon(Icons.description), "Terms & Conditions", () {}),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => VerifyOTPScreen(),
                  //   ),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  minimumSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(
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
    );
  }

  Widget profileTileButton(icon, text, onPressed) {
    return Column(
      children: [
        ListTile(
          leading: icon,
          trailing: IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ),
          contentPadding: const EdgeInsets.all(0),
          title: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
          onTap: onPressed,
        ),
        const Divider()
      ],
    );
  }
}
