import 'dart:math';

import 'package:flutter/material.dart';

class ScalingQuery {
  var _shortDimension;
  var _longDimension;

  ScalingQuery(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    this._shortDimension = width < height ? width : height;
    this._longDimension = width < height ? height : width;
  }

  double fontSize(double size) {
    var tempLongDimension = (16 / 9) * this._shortDimension;
    return sqrt(pow(tempLongDimension, 2) + pow(_shortDimension, 2)) *
        (size / 100);
  }
}
