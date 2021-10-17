
import 'dart:io';

import 'package:mabro/core/models/all_transactions_history.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/commons/transaction_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';

class NairaWalletPage extends StatefulWidget {
  final String user;

  const NairaWalletPage({Key key, this.user}) : super(key: key);
  @override
  _NairaWalletPageState createState() => _NairaWalletPageState();
}

class _NairaWalletPageState extends State<NairaWalletPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;


  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
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
            appBar: TopBar(
              backgroundColorStart: ColorConstants.primaryColor,
              backgroundColorEnd: ColorConstants.secondaryColor,
              title: 'Naira Wallet',
              icon:
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              onPressed: null,
              textColor: Colors.white,
              iconColor: Colors.white,
            ),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Container(child:
                    Column(
                      children: [
                        SizedBox(height: 20),
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
                            color: ColorConstants.primaryLighterColor,
                          ),
                          child: Column(children: [
                            Text(
                            'Wallet Balance',
                            style: TextStyle(
                              color: ColorConstants.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'NGN 5,782',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Fund Wallet',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(children: [
                              Expanded(
                                child: NormalFields(
                                  width: MediaQuery.of(context).size.width,
                                  isEditable: true,
                                  hintText: 'Amount',
                                  labelText: '',
                                  onChanged: (name) {},
                                  //controller: accountNameController,
                                ),
                              ),

                              CustomButton(
                                  margin: 0,
                                  disableButton: true,
                                  onPressed: () {

                                  },
                                  text: 'Fund'),
                            ],)


                          ],)
                        )
                      ],
                    )
                    ,)
                ],
              ),
            ),
          )
          // body: Padding(
          //   padding: const EdgeInsets.all(0.0),
          //   child: TabBarView(
          //     children: [
          //       buildTransactionHistory(
          //           context, 'https://mabro.ng/dev/_app/transactions/all'),
          //       buildTransactionHistory(context,
          //           'https://mabro.ng/dev/_app/transactions/all/complete'),
          //       buildTransactionHistory(context,
          //           'https://mabro.ng/dev/_app/transactions/all/pending'),
          //
          //     ],
          //     controller: _tabController,
          //   ),
          // ),
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
          if (allTransactionHistory.data.transactions.length == 0) {
            return Center(
              child: Text(
                'No Results for this transaction',
                style: TextStyle(
                    fontSize: 16, color: ColorConstants.secondaryColor, fontWeight: FontWeight.w200),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: allTransactionHistory.data.transactions.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, index) {
                return Container(
                    child: transactionList(
                      index: index,
                      amount: allTransactionHistory.data.transactions[index].amount.toString(),
                      createdDate: allTransactionHistory.data.transactions[index].createdAt,
                      transactionTitle: allTransactionHistory.data.transactions[index].activity,
                      transactionDetails:
                      allTransactionHistory.data.transactions[index].description,
                      currency: 'NGN',
                    ));
              },
            );
          }
        } else if (snapshot.hasError) {
          return Center(
            child: GestureDetector(
              onTap: () {
                setState(() {

                });
              },
              child: Text(
                'Error in network',
                style: TextStyle(
                    fontSize: 16, color: ColorConstants.whiteLighterColor),
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
    int index,
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
        // Positioned(
        //   left: 20,
        //   child: Container(
        //       child: Dash(
        //     direction: Axis.vertical,
        //     length: 100,
        //     dashThickness: 2.0,
        //     dashLength: 10,
        //     dashColor: ColorConstants.whiteLighterColor,
        //   )),
        // ),
        TransactionContainer(
            index: index,
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
