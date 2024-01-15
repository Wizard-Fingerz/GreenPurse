
import 'package:flutter/material.dart';
import 'package:greenpurse/utils/colors.dart';

class UserTransactionList extends StatefulWidget {
  @override
  _UserTransactionListState createState() => _UserTransactionListState();
}

class _UserTransactionListState extends State<UserTransactionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.50,
      decoration: BoxDecoration(
        border: Border.all(width: 0.1, color: AppColors.greyish),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Beneficiary'),
                Tab(text: 'Recent Users'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Tab 1: Beneficiary List
                  Container(
                    child: const Center(
                      child: Text('Beneficiary List'),
                    ),
                  ),
                  // Tab 2: Recent Users
                  Container(
                    child: const Center(
                      child: Text('Recent Users'),
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
