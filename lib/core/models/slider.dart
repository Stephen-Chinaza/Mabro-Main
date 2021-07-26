import 'package:mabro/constants/string_constants/string_constants.dart';
import 'package:flutter/cupertino.dart';

class Slider {
  final String sliderImageUrl;
  final String sliderHeading;
  final String sliderSubHeading;
  final String skipBtn;

  Slider(
      {@required this.sliderImageUrl,
      @required this.sliderHeading,
      @required this.sliderSubHeading,
      this.skipBtn});
}

final sliderArrayList = [
  Slider(
      sliderImageUrl: 'assets/images/onboard1.png',
      sliderHeading: Constants.SLIDER_HEADING_1,
      sliderSubHeading: Constants.SLIDER_DESC1,
      skipBtn: Constants.SKIP),
  Slider(
      sliderImageUrl: 'assets/images/onboard2.png',
      sliderHeading: Constants.SLIDER_HEADING_2,
      sliderSubHeading: Constants.SLIDER_DESC2,
      skipBtn: Constants.SKIP),
  Slider(
      sliderImageUrl: 'assets/images/onboard3.png',
      sliderHeading: Constants.SLIDER_HEADING_3,
      sliderSubHeading: Constants.SLIDER_DESC3,
      skipBtn: Constants.SKIP),
  Slider(
      sliderImageUrl: 'assets/images/onboard4.png',
      sliderHeading: Constants.SLIDER_HEADING_4,
      sliderSubHeading: Constants.SLIDER_DESC4,
      skipBtn: ""),
];

final List<String> homeImages = [
  'assets/images/onboard1.png',
  'assets/images/onboard2.png',
  'assets/images/onboard3.png',
  'assets/images/onboard4.png',
];
