import 'package:flutter/material.dart';

screenSizeConfig(BuildContext context, double originalSize) {
  double oS = originalSize / 375;
  return MediaQuery.of(context).size.width * oS;
}
