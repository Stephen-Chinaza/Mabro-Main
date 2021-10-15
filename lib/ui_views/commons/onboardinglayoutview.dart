import 'package:mabro/core/models/slider.dart';
import 'package:mabro/ui_views/commons/slider_item.dart';
import 'package:mabro/ui_views/widgets/onboarding_sliding_dots/slide_dots.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/buttons/get_started_button.dart';

class OnBoardingLayoutView extends StatefulWidget {
  final String userPin;

  const OnBoardingLayoutView({Key key, this.userPin}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _OnBoardingLayoutView();
}

class _OnBoardingLayoutView extends State<OnBoardingLayoutView> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) => SliderLayout();

  bool inFinalPage() {
    if (_currentPage == sliderArrayList.length - 1) {
      return true;
    }
    return false;
  }

  Widget SliderLayout() => Container(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.17),
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: sliderArrayList.length,
                itemBuilder: (ctx, i) => SlideItem(i),
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 40),
                Container(
                  alignment: AlignmentDirectional.center,
                  margin: EdgeInsets.only(
                      bottom: 0.0,
                      top: MediaQuery.of(context).size.height * 0.28),
                  child: inFinalPage()
                      ? GetStartedButton()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for (int i = 0; i < sliderArrayList.length; i++)
                              if (i == _currentPage)
                                SlideDots(true)
                              else
                                SlideDots(false)
                          ],
                        ),
                ),
              ],
            ),
            Positioned(
                bottom: 50,
                left: 14,
                right: 14,
                child: inFinalPage()
                    ? Container()
                    : GetStartedButton(userPin: widget.userPin)),
          ],
        ),
      );
}
