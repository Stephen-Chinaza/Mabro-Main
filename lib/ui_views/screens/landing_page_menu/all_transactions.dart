import 'package:mabro/core/models/all_transactions_history.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/transaction_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

class AllTransactions extends StatefulWidget {
  final String user;

  const AllTransactions({Key key, this.user}) : super(key: key);
  @override
  _AllTransactionsState createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildFirstContainer(),
        buildSecondContainer(),
        Scaffold(
          backgroundColor: ColorConstants.primaryColor,
          appBar: new AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: ColorConstants.primaryLighterColor,
              ),
            ),
            centerTitle: false,
            title: new Text("Transactions History",
                style: TextStyle(fontSize: 14, color: ColorConstants.whiteLighterColor,)),
            automaticallyImplyLeading: false,
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                new Tab(text: 'All'),
                new Tab(
                  text: 'Successful',
                ),
                new Tab(
                  text: 'Declined',
                ),
                new Tab(
                  text: 'Pending',
                ),
              ],
              controller: _tabController,
              unselectedLabelColor: ColorConstants.whiteLighterColor,
              unselectedLabelStyle: TextStyle(fontSize: 14),
              labelStyle: TextStyle(fontSize: 14),
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.white,
            ),
            bottomOpacity: 1,
          ),
          body: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              color: ColorConstants.primaryLighterColor,
              child:
              TabBarView(
                children: [
                  buildTransactionHistory(
                      context, 'https://iceztech.com/mabro/account/transactions'),
                  buildTransactionHistory(context,
                      'https://iceztech.com/mabro/account/transactions/success'),
                  buildTransactionHistory(context,
                      'https://iceztech.com/mabro/account/transactions/pending'),
                  buildTransactionHistory(context,
                      'https://iceztech.com/mabro/account/transactions/declined'),
                ],
                controller: _tabController,
              ),
            ),
          ),
        ),
      ],
    );
  }

  FutureBuilder<AllTransactionHistory> buildTransactionHistory(
      BuildContext context, String url) {
    return FutureBuilder(
      future: HttpService.transactionHistory(context, widget.user, url),
      builder: (BuildContext context,
          AsyncSnapshot<AllTransactionHistory> snapshot) {
        AllTransactionHistory allTransactionHistory = snapshot.data;

        if (snapshot.hasData) {
          if (allTransactionHistory.data.length == 0) {
            return Center(
              child: Text(
                'No Results for this transaction',
                style: TextStyle(
                    fontSize: 16, color: ColorConstants.secondaryColor),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: allTransactionHistory.data.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, index) {
                return Container(
                  child: transactionList(
                      amount: allTransactionHistory.data[index].amount,
                      createdDate: allTransactionHistory.data[index].createdAt,
                      transactionTitle: allTransactionHistory.data[index].title,
                      transactionDetails:
                          allTransactionHistory.data[index].description,
                      currency: allTransactionHistory.data[index].currency),
                );
              },
            );
          }
        } else if (snapshot.hasError) {
          return Center(
            child: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error in network',
                    style: TextStyle(
                        fontSize: 16, color: ColorConstants.whiteLighterColor),
                  ),
                  Icon(
                    Icons.refresh,
                    size: 25,
                  )
                ],
              ),
            ),
          );
        } else {
          return Center(
              child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(ColorConstants.secondaryColor),
          ));
        }
      },
    );
  }

  Widget transactionList({
    String amount,
    IconData iconData,
    Color colorData,
    String transactionTitle,
    String createdDate,
    String transactionDetails,
    String currency,
  }) {
    return Stack(
      children: [
        Positioned(
          left: 20,
          child: Container(
              child: Dash(
            direction: Axis.vertical,
            length: 100,
            dashThickness: 2.0,
            dashLength: 10,
            dashColor: ColorConstants.whiteLighterColor,
          )),
        ),
        TransactionContainer(
            amount: '$currency $amount',
            icon: iconData,
            color: colorData,
            transactionName: transactionTitle,
            date: createdDate,
            transactionDetails: transactionDetails),
      ],
    );
  }
}
