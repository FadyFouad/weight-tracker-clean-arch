import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double getDeviceHeight() => MediaQuery.of(this).size.height;

  double getDeviceWidth() => MediaQuery.of(this).size.width;
}
