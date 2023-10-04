import 'package:easy_beck/feature/actions/model/action_icon.dart' as model;
import 'package:flutter/widgets.dart';

class AwesomeIcon implements model.ActionIcon {
  final IconData iconData;

  const AwesomeIcon(this.iconData);

  AwesomeIcon.fromCodePoint(int codePoint)
      : iconData = IconData(codePoint,
            fontFamily: "LineAwesomeIcons",
            fontPackage: "flutter_iconpicker",
            matchTextDirection: false);

  int get codePoint => iconData.codePoint;
}
