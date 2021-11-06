import 'package:flutter/painting.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionContainer extends StatelessWidget {
  final String transactionName, amount, date, transactionDetails;
  final IconData icon;
  final Color color;
  final int index;
  const TransactionContainer({
    Key key,
    this.transactionName,
    this.transactionDetails,
    this.amount,
    this.icon,
    this.color,
    this.date,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                child: Stack(
                  children: [
                    Container(
                      color: ColorConstants.primaryColor,
                      height: 270,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: ColorConstants.primaryLighterColor),
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      transactionName,
                                      style: TextStyle(
                                          color:
                                              ColorConstants.whiteLighterColor,
                                          fontSize: 16),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 20,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Dash(
                              direction: Axis.horizontal,
                              length: 280,
                              dashThickness: 1.0,
                              dashLength: 5,
                              dashColor: ColorConstants.whiteLighterColor,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Transaction amount: ' + amount,
                                style: TextStyle(
                                    color: ColorConstants.whiteLighterColor,
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Dash(
                              direction: Axis.horizontal,
                              length: 280,
                              dashThickness: 1.0,
                              dashLength: 5,
                              dashColor: ColorConstants.whiteLighterColor,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Transaction date: ' + date,
                                style: TextStyle(
                                    color: ColorConstants.whiteLighterColor,
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Dash(
                              direction: Axis.horizontal,
                              length: 280,
                              dashThickness: 1.0,
                              dashLength: 5,
                              dashColor: ColorConstants.whiteLighterColor,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Transaction details: ' + transactionDetails,
                                style: TextStyle(
                                    color: ColorConstants.whiteLighterColor,
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
      child: Container(
        decoration: BoxDecoration(
          color: index % 2 != 0
              ? ColorConstants.primaryColor
              : ColorConstants.primaryLighterColor,
          border: Border.all(
            color: ColorConstants
                .whiteLighterColor, //                   <--- border color
            width: 0.2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    icon,
                    color: color,
                    size: 25,
                  ),

                  //Image.asset('assets/images/transaction.png', width: 30, height: 30),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextStyles.textDetails(
                          textSize: 14,
                          textValue: transactionName,
                          textColor: ColorConstants.white),
                      SizedBox(
                        height: 5,
                      ),
                      TextStyles.textDetails(
                          textSize: 12,
                          textValue: date,
                          textColor: ColorConstants.whiteLighterColor),
                    ],
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: TextStyles.textDetails(
                      textSize: 13,
                      textValue: amount,
                      textColor: ColorConstants.white)),
            ],
          ),
        ),
      ),
    );
  }
}
