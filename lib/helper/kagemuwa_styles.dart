import 'package:flutter/material.dart';
import 'package:kagemuwa_umzug_common/helper/kagemuwa_colors.dart';

class KAGEMUWAStyles {
  KAGEMUWAStyles._(); // this basically makes it so you can instantiate this class

  // text styles
  static const TextStyle normalTextStyleLarge = TextStyle(
      fontSize: 18.0,
      color: KAGEMUWAColors.tfseHeaderTextColor,
      fontWeight: FontWeight.bold
  );

  static const TextStyle normalTextStyle = TextStyle(
      fontSize: 14.0,
      color: KAGEMUWAColors.tfseHeaderTextColor,
      fontWeight: FontWeight.bold
  );

  static const TextStyle normalTextStyleSmall = TextStyle(
      fontSize: 11.0,
      color: KAGEMUWAColors.tfseHeaderTextColor,
      fontWeight: FontWeight.bold
  );

  static const TextStyle normalTextStyleBlack = TextStyle(
      fontSize: 14.0,
      color: Colors.black,
      fontWeight: FontWeight.bold
  );

  // menu card
  static const TextStyle menuCardStyle = TextStyle(
      fontSize: 22.0,
      color: Colors.white,
      letterSpacing: 1.1,
      fontWeight: FontWeight.bold
  );

  // cards
  static const TextStyle cardHeaderStyle = TextStyle(
      fontSize: 18.0,
      color: KAGEMUWAColors.cardHeaderText,
      fontWeight: FontWeight.bold
  );
  static const TextStyle cardBodyStyle = TextStyle(
      fontSize: 14.0,
      color:   KAGEMUWAColors.cardBodyText,
      fontWeight: FontWeight.normal
  );
  static const TextStyle cardTextFieldStyle = TextStyle(
      fontSize: 14.0,
      color:   KAGEMUWAColors.cardTextFieldColor,
      fontWeight: FontWeight.normal
  );
}