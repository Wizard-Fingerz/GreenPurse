import 'package:flutter/material.dart';
import 'package:greenpurse/utils/colors.dart';

class WalletPage extends StatelessWidget {
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
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_outlined,
                color: AppColors.green,
              ),
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/card_background.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 55),
                  Center(
                    child: Text(
                      "**** **** **** 2345",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Amelia Barlow",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        )),
                  ),
                  ListTile(
                    leading: Text("NGN70,000,000",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        )),
                    trailing: Column(
                      children: [
                        Text("Expiry Date",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            )),
                        Text("02/30",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                walletButton(
                    "Transfer",
                    Icon(
                      Icons.send,
                      color: AppColors.whitish,
                    ),
                    () {}),
                walletButton(
                    "Deposit",
                    Icon(
                      Icons.upload,
                      color: AppColors.whitish,
                    ),
                    () {}),
                walletButton(
                    "Withdraw",
                    Icon(
                      Icons.download,
                      color: AppColors.whitish,
                    ),
                    () {}),
                walletButton(
                    "Invest",
                    Icon(
                      Icons.timeline,
                      color: AppColors.whitish,
                    ),
                    () {})
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: AppColors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: const Text("Freeze card",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )),
                    subtitle: Text("Tap again to unfreeze",
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Settings",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )),
                    subtitle: Text("View address, terminate card and more",
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(text: 'Recent Transactions'),
                        Tab(text: 'Quick Links'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // Tab 1: Recent Transactions
                          Container(
                            child: Center(
                              child: Text('Recent Transactions List'),
                            ),
                          ),
                          // Tab 2: Quick Link
                          Container(
                            child: Center(
                              child: Text('Quick Link List'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget walletButton(name, icon, onTap) {
    return GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.greyish),
              child: icon,
            ),
            Text(name,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.greyish))
          ],
        ));
  }
}
