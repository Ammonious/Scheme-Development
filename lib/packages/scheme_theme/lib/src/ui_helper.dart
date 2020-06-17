import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'package:scheme_utilities/scheme_utilities.dart';



Duration get normalDuration => Duration(milliseconds: 350);
schemeGradient({Color color, Color colorOne, Color colorTwo, Alignment begin, Alignment end}) {
  Color cOne = colorOne ?? color;
  Color cTwo = colorTwo ?? color;

  if (colorIsBlack(cOne)) {
    cOne = cOne.shade200;
    cTwo = cOne.shade500;
  }
  return LinearGradient(
      begin: begin ?? Alignment.topLeft,
      end: end ?? Alignment.bottomRight,
      stops: [
        0.1,
        1
      ],
      colors: [
        cOne,
        cTwo,
      ]);
}

enum GradientType { radial, linear, sweep }


const List<BoxShadow> flatShadow = [
  BoxShadow(blurRadius: 0, color: Colors.transparent, offset: Offset(0, 0))
];
const List<BoxShadow> normalShadow = [
  BoxShadow(blurRadius: 4.5, color: Colors.black26, offset: Offset(0, 2))
];
const List<BoxShadow> slightShadow = [
  BoxShadow(blurRadius: 1.5, color: Colors.black12, offset: Offset(0, 1))
];
const List<BoxShadow> liftedShadow = [
  BoxShadow(blurRadius: 7.5, color: Colors.black38, offset: Offset(0, 4))
];
const List<BoxShadow> largeShadow = [
  BoxShadow(blurRadius: 25.50, color: Colors.black45, offset: Offset(0, 4))
];
const List<BoxShadow> wideShadow = [
  BoxShadow(blurRadius: 45.50, color: Colors.black26, offset: Offset(0, 4))
];

const List<BoxShadow> bottomBarShadow = [
  BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -4))
];
List<BoxShadow> get neuShadow => [
  BoxShadow(
      color: Colors.white.withOpacity(0.5), spreadRadius: -5, offset: Offset(-5, -5), blurRadius: 30),
  BoxShadow(
      color: Colors.white.darkenBy(40).withOpacity(.2),
      spreadRadius: 2,
      offset: Offset(7, 7),
      blurRadius: 20)
];


const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);

const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceMedium = SizedBox(height: 25.0);
const Widget verticalSpaceLarge = SizedBox(height: 50.0);
const Widget verticalSpaceMassive = SizedBox(height: 120.0);

Widget spacedDivider = Column(
  children: const <Widget>[
    verticalSpaceMedium,
    const Divider(color: Colors.blueGrey, height: 5.0),
    verticalSpaceMedium,
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height);

double get screenWidth => Get.width;
double get screenHeight => Get.height;

double screenHeightFraction({int dividedBy = 1, double offsetBy = 0}) =>
    (screenHeight - offsetBy) / dividedBy;

double screenWidthFraction({int dividedBy = 1, double offsetBy = 0}) =>
    (screenWidth - offsetBy) / dividedBy;

double get halfScreenWidth => screenWidthFraction(dividedBy: 2);

double get thirdScreenWidth => screenWidthFraction(dividedBy: 3);

smallPhone(double screenHeight) => Get.height < 600;

screenUtilSmallerThan(double height) => Get.height > height;

screenBiggerThan(double screenWidth) => Get.width > screenWidth;


const kSwatchSize = 48.0;

get mobileCardRadius => BorderRadius.only(
    topLeft: Radius.circular(24), topRight: Radius.circular(24));

get desktopCardRadius => BorderRadius.only(topLeft: Radius.circular(24));


get topCardRadius => BorderRadius.only(
  topLeft: Radius.circular(32),
  topRight: Radius.circular(32),
);

double get appbarHeight => kToolbarHeight;
double get topPadding => Get.mediaQuery.padding.top;
double get toolbarWithPadding => kToolbarHeight + topPadding;
double get toolbarHeight => kToolbarHeight;
double get bottomPadding => Get.mediaQuery.padding.bottom;
double get appbarWithPadding => kToolbarHeight + topPadding;
double get bottomBarWithPadding => kToolbarHeight + bottomPadding;