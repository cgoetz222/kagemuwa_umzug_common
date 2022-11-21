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

  static const TextStyle ratingItemTextStyle = TextStyle(
      fontSize: 14.0,
      color: KAGEMUWAColors.ratingItemTextColor,
      fontWeight: FontWeight.bold
  );

  // menu card
  static const TextStyle menuCardStyle = TextStyle(
      fontSize: 22.0,
      color: Colors.white,
      letterSpacing: 1.1,
      fontWeight: FontWeight.bold
  );

  // cards dark
  static const TextStyle cardDarkHeaderStyle = TextStyle(
      fontSize: 18.0,
      color: KAGEMUWAColors.cardDarkHeaderText,
      fontWeight: FontWeight.bold
  );
  static const TextStyle cardDarkBodyStyle = TextStyle(
      fontSize: 14.0,
      color:   KAGEMUWAColors.cardDarkBodyText,
      fontWeight: FontWeight.normal
  );
  static const TextStyle cardDarkTextFieldStyle = TextStyle(
      fontSize: 14.0,
      color:   KAGEMUWAColors.cardDarkTextFieldColor,
      fontWeight: FontWeight.normal
  );

  // cards bright
  static const TextStyle cardBrightHeaderStyle = TextStyle(
      fontSize: 18.0,
      color: KAGEMUWAColors.cardBrightHeaderText,
      fontWeight: FontWeight.bold
  );
  static const TextStyle cardBrightSubHeaderStyle = TextStyle(
      fontSize: 18.0,
      color: KAGEMUWAColors.cardBrightSubHeaderText,
      fontWeight: FontWeight.bold
  );
  static const TextStyle cardBrightBodyStyle = TextStyle(
      fontSize: 14.0,
      color: KAGEMUWAColors.cardBrightBodyText,
      fontWeight: FontWeight.normal
  );

  // start screen
  static const TextStyle startPageTextFieldStyle = TextStyle(
      fontFamily: 'cursive',
      fontSize: 36.0,
      color: KAGEMUWAColors.startTextFieldColor,
      fontWeight: FontWeight.bold,
  );

  // thank you screen
  static const TextStyle thankYouPageTextFieldStyle = TextStyle(
    fontFamily: 'cursive',
    fontSize: 24.0,
    color: KAGEMUWAColors.cardBrightBodyText,
    fontWeight: FontWeight.bold,

  );

  // rating screen
  static const TextStyle ratingHeaderStyle = TextStyle(
      fontSize: 18.0,
      color: KAGEMUWAColors.ratingHeaderTextColor,
      fontWeight: FontWeight.bold
  );
}