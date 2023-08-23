import 'package:flutter/material.dart';

extension WidgetSpacing on num {
  SizedBox get spacingW => SizedBox(width: this as double);
  SizedBox get spacingH => SizedBox(height: this as double);
}

SizedBox sizedBoxH(double size) {
  return SizedBox(height: size,);
}

SizedBox sizedBoxW(double size) {
  return SizedBox(width: size,);
}