import 'package:flutter/painting.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/widgets/texts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionContainer extends StatelessWidget {
  final String transactionName, amount, date,transactionDetails;
  final IconData icon;
  final Color color;
  const TransactionContainer({
    Key key,
    this.transactionName,
    this.transactionDetails,
    this.amount,
    this.icon,
    this.color,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3),
      child: GestureDetector(
        onTap: (){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(5.0)), //this right here
                  child: Stack(
                    children: [
                      Container(
                        height: 230,
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(gradient: ColorConstants.primaryGradient),
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                child:
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Transaction Info',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                          child: Icon(Icons.close, color: Colors.white, size: 20,))
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(transactionName,
                                  style: TextStyle(color: Colors.black, fontSize: 16,),
                                ),
                              ),
                              Dash(
                                direction: Axis.horizontal,
                                length: 280,
                                dashThickness: 1.0,
                                dashLength: 5,
                                dashColor: Colors.grey.shade400,
                              ),
                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Transaction amount: '+amount,
                                  style: TextStyle(color: Colors.black, fontSize: 12, fontStyle: FontStyle.italic),
                                ),
                              ),
                              Dash(
                                direction: Axis.horizontal,
                                length: 280,
                                dashThickness: 1.0,
                                dashLength: 5,
                                dashColor: Colors.grey.shade400,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Transaction date: '+date,
                                  style: TextStyle(color: Colors.black, fontSize: 12,  fontStyle: FontStyle.italic),
                                ),
                              ),
                              Dash(
                                direction: Axis.horizontal,
                                length: 280,
                                dashThickness: 1.0,
                                dashLength: 5,
                                dashColor: Colors.grey.shade400,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Transaction details: '+transactionDetails,
                                  style: TextStyle(color: Colors.black, fontSize: 12,  fontStyle: FontStyle.italic),
                                ),
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
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Icon(icon, color: color),
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
                        textSize: 13,
                        textValue: transactionName,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextStyles.textDetails(
                        textSize: 12,
                        textValue: date,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 120,
                  ),
                  TextStyles.textDetails(
                    textSize: 12,
                    textValue: amount,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
