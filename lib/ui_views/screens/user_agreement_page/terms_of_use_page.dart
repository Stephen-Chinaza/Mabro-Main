
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mabro/res/colors.dart';

class TermsOfUsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back, color: Colors.white,),
          onPressed: ()=>Navigator.of(context).pop(),
        ),
        title: Text("Users Terms and Conditions".toUpperCase(), style: TextStyle(
            fontSize: 16.0,
            color: ColorConstants.whiteColor,
            fontWeight: FontWeight.w600
        ),),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: <Widget>[


                SizedBox(height: 20.0,),
                _buildStep(
                  leadingTitle: "01",
                  title: "User Policies".toUpperCase(),
                  content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent lacinia, odio ut placerat finibus, ipsum risus consectetur ligula, non mattis mi neque ac mi. Vivamus quis tellus sed erat eleifend pharetra ac non diam. Integer vitae ipsum congue, vestibulum eros quis, interdum tellus. Nunc vel dictum elit. Curabitur suscipit scelerisque."

                ),
                SizedBox(height: 30.0,),
                _buildStep(
                  leadingTitle: "02",
                  title: "Does and Donts".toUpperCase(),
                  content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent lacinia, odio ut placerat finibus, ipsum risus consectetur ligula, non mattis mi neque ac mi. Vivamus quis tellus sed erat eleifend pharetra ac non diam. Integer vitae ipsum congue, vestibulum eros quis, interdum tellus. Nunc vel dictum elit. Curabitur suscipit scelerisque."

                ),
                SizedBox(height: 30.0,),
                _buildStep(
                  leadingTitle: "03",
                  title: "How to Use".toUpperCase(),
                  content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent lacinia, odio ut placerat finibus, ipsum risus consectetur ligula, non mattis mi neque ac mi. Vivamus quis tellus sed erat eleifend pharetra ac non diam. Integer vitae ipsum congue, vestibulum eros quis, interdum tellus. Nunc vel dictum elit. Curabitur suscipit scelerisque."

                ),
              ],
            ),
          ),
         
        ],
      ),
    );
  }

  Container _buildBottomImage(String image) {
    return Container(
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(image: CachedNetworkImageProvider(image),fit:BoxFit.cover)

                  ),
                );
  }

  Widget _buildStep({String leadingTitle, String title, String content}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Material(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: ColorConstants.secondaryColor,
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Text(leadingTitle, style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0
            )),
          ),
        ),
        SizedBox(width: 16.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                  color: ColorConstants.whiteColor,
              )),
              SizedBox(height: 10.0,),
              Text(content, style: TextStyle(
                  color: ColorConstants.whiteLighterColor,

                  fontSize: 14.0
              )),
            ],
          ),
        )
      ],
    );
  }
}