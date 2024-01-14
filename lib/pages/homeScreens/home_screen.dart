import 'package:flutter/material.dart';
import 'package:greenpurse/pages/homeScreens/green_bot.dart';
import 'package:greenpurse/pages/homeScreens/home_page.dart';
import 'package:greenpurse/pages/homeScreens/market_page.dart';
import 'package:greenpurse/pages/homeScreens/profile.dart';
import 'package:greenpurse/pages/homeScreens/wallet/wallet_home.dart';
import 'package:greenpurse/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pageContents = [
    HomeContent(),
    MarketPage(),
    const ChatMessages(),
    WalletPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageContents[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.green, // Selected item text color
        unselectedItemColor: Colors.grey, // Unselected item text color
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'GreenBot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   elevation: 2.0, // Adjust the elevation as needed
      //   shape: RoundedRectangleBorder(
      //     borderRadius:
      //         BorderRadius.circular(30.0), // Adjust the border radius as needed
      //   ),
      //   child: Image.asset(
      //         'assets/green_purse_logo.png',
      //         height: 50,
      //       ),
      // ),
    );
  }
}
