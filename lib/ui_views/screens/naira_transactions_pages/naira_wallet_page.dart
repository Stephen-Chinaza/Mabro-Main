import 'dart:io';

import 'package:flutter/painting.dart';
import 'package:mabro/constants/navigator/navigation_constant.dart';
import 'package:mabro/core/models/all_transactions_history.dart';
import 'package:mabro/core/services/repositories.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/scaffold_background_page.dart/scaffold_background.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';
import 'package:mabro/ui_views/commons/transaction_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:mabro/ui_views/screens/flutterwave_payment/flutterwave_payment.dart';
import 'package:mabro/ui_views/widgets/buttons/custom_button.dart';
import 'package:mabro/ui_views/widgets/snackbar/snack.dart';
import 'package:mabro/ui_views/widgets/textfield/normal_textfield.dart';

class NairaWalletPage extends StatefulWidget {
  final String user;

  const NairaWalletPage({Key key, this.user}) : super(key: key);
  @override
  _NairaWalletPageState createState() => _NairaWalletPageState();
}

class _NairaWalletPageState extends State<NairaWalletPage>
    with SingleTickerProviderStateMixin {

  TextEditingController amountController = TextEditingController();

  @override
  void initState() {

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
              icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              onPressed: null,
              textColor: Colors.white,
              iconColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                child: ListView(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: ColorConstants.primaryLighterColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0, top: 4.0,left: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Wallet Balance',
                                            style: TextStyle(
                                              color: ColorConstants.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Image.asset('assets/images/naira.jpg', width: 30, height: 30),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        'NGN 5,782',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        'Fund Wallet',
                                        style: TextStyle(
                                          color: ColorConstants.whiteLighterColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: NormalFields(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              isEditable: true,
                                              hintText: 'Amount',
                                              labelText: '',
                                              textInputType: TextInputType.number,
                                              controller: amountController,
                                              onChanged: (name) {},
                                              //controller: accountNameController,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Expanded(
                                          flex: 2,
                                          child: CustomButton(
                                              margin: 0,
                                              disableButton: true,
                                              onPressed: () {
                                                makePayment();
                                              },
                                              text: 'Fund'),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),),
                     SizedBox(height: 20),
                     Expanded(
                       flex: 8,
                       child: buildTransactionHistory(
                            context, 'https://mabro.ng/dev/_app/transactions/fund-wallet'),
                     ),
                  ],
                ),
              ),
            )
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
                    fontSize: 16,
                    color: ColorConstants.secondaryColor,
                    fontWeight: FontWeight.w200),
              ),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: allTransactionHistory.data.transactions.length + 1,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, index) {
                  return (index == 0) ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                      color: ColorConstants.primaryLighterColor,
                      border: Border.all(
                        color: ColorConstants.whiteLighterColor, //                   <--- border color
                        width: 0.2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 6,
                              child: Text(
                                'Recent Wallet transactions',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: ColorConstants.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: ColorConstants.secondaryColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(
                                    child: Text(
                                      'All Transactions',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ColorConstants.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],),
                    )
                  ) :Container(
                      child: transactionList(
                    index: index,
                    amount: allTransactionHistory.data.transactions[index].amount
                        .toString(),
                    createdDate:
                        allTransactionHistory.data.transactions[index].createdAt,
                    transactionTitle:
                        allTransactionHistory.data.transactions[index].activity,
                    transactionDetails: allTransactionHistory
                        .data.transactions[index].description,
                    currency: 'NGN',
                  ));
                },
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Center(
            child: GestureDetector(
              onTap: () {
                setState(() {});
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
    return TransactionContainer(
        index: index,
        amount: '$currency $amount',
        icon: iconData,
        color: colorData,
        transactionName: transactionTitle,
        date: createdDate,
        transactionDetails: transactionDetails);
  }

  void makePayment() {
    if(amountController.text.isEmpty){
      ShowSnackBar.showInSnackBar(
          value: 'Enter amount to proceed', context: context, timer: 5);

    }else{
      kopenPage(context, CardPayment(amount: int.tryParse(amountController.text)));
    }
  }
}
