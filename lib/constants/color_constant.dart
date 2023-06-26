
import 'package:flutter/material.dart';
import 'package:untitled/constants/sizeConstant.dart';

class BaseTheme {
  Color get primaryTheme => Colors.white;
  Color get buttonColor => fromHex('#FE9013');
  Color get textGrayColor => fromHex("#5E5E5E");

  List<BoxShadow> get getShadow {
    return [
      BoxShadow(
        offset: Offset(2, 2),
        color: Colors.black26,
        blurRadius: MySize.getHeight(2),
        spreadRadius: MySize.getHeight(2),
      ),
      BoxShadow(
        offset: Offset(-1, -1),
        color: Colors.white.withOpacity(0.8),
        blurRadius: MySize.getHeight(2),
        spreadRadius: MySize.getHeight(2),
      ),
    ];
  }

  List<BoxShadow> get getShadow3 {
    return [
      BoxShadow(
        offset: Offset(2, 2),
        color: Colors.black12,
        blurRadius: MySize.getHeight(0.5),
        spreadRadius: MySize.getHeight(0.5),
      ),
      BoxShadow(
        offset: Offset(-1, -1),
        color: Colors.white.withOpacity(0.8),
        blurRadius: MySize.getHeight(0.5),
        spreadRadius: MySize.getHeight(0.5),
      ),
    ];
  }

  List<BoxShadow> get getShadow2 {
    return [
      BoxShadow(
          offset: Offset(MySize.getWidth(2.5), MySize.getHeight(2.5)),
          color: Color(0xffAEAEC0).withOpacity(0.4),
          blurRadius: MySize.getHeight(5),
          spreadRadius: MySize.getHeight(0.2)),
      BoxShadow(
          offset: Offset(MySize.getWidth(-1.67), MySize.getHeight(-1.67)),
          color: Color(0xffFFFFFF),
          blurRadius: MySize.getHeight(5),
          spreadRadius: MySize.getHeight(0.2)),
    ];
  }
}

BaseTheme get appTheme => BaseTheme();

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
