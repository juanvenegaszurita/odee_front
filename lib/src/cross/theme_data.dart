import 'package:flutter/material.dart';

Map<int, Color> _getSwatch(Color color) {
  final hslColor = HSLColor.fromColor(color);
  final lightness = hslColor.lightness;

  const lowDivisor = 6;
  const highDivisor = 5;

  final lowStep = (1.0 - lightness) / lowDivisor;
  final highStep = lightness / highDivisor;

  return {
    50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
    100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
    200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
    300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
    400: (hslColor.withLightness(lightness + lowStep)).toColor(),
    500: (hslColor.withLightness(lightness)).toColor(),
    600: (hslColor.withLightness(lightness - highStep)).toColor(),
    700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
    800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
    900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
  };
}

const primary = Color.fromRGBO(0, 49, 226, 1);
const secondary = Color.fromRGBO(81, 0, 157, 1);
const tertiary = Color.fromRGBO(41, 171, 226, 1);
const error = Color.fromRGBO(186, 26, 26, 1);
const neutral = Color.fromRGBO(107, 114, 128, 1);
const neutralVariant = Color.fromRGBO(94, 94, 103, 1);
const lightBlue = Color.fromRGBO(28, 223, 236, 1);
const lightPurple = Color.fromRGBO(153, 5, 135, 1);
const surfaceLigh = Color.fromRGBO(253, 251, 255, 1);
const surfaceDark = Color.fromRGBO(0, 28, 59, 1);

// Light colors
final primaryLightMC = MaterialColor(primary.value, _getSwatch(primary));
final primaryLight = primaryLightMC[40];
final onPrimaryLight = primaryLightMC[100];
final primaryContainerLight = primaryLightMC[90];
final onPrimaryContainerLight = primaryLightMC[10];

final secondaryLightMC = MaterialColor(secondary.value, _getSwatch(secondary));
final secondaryLight = secondaryLightMC[40];
final onSecondaryLight = secondaryLightMC[100];
final secondaryContainerLight = secondaryLightMC[90];
final onSecondaryContainerLight = secondaryLightMC[10];

final tertiaryLightMC = MaterialColor(tertiary.value, _getSwatch(tertiary));
final tertiaryLight = tertiaryLightMC[40];
final onTertiaryLight = tertiaryLightMC[100];
final tertiaryContainerLight = tertiaryLightMC[90];
final onTertiaryContainerLight = tertiaryLightMC[10];

final errorLightMC = MaterialColor(error.value, _getSwatch(error));
final errorLight = errorLightMC[40];
final onErrorLight = errorLightMC[100];
final errorContainerLight = errorLightMC[90];
final onErrorContainerLight = errorLightMC[10];

final backgroundLightMC = MaterialColor(neutral.value, _getSwatch(neutral));
final backgroundLight = backgroundLightMC[40];
final onBackgroundLight = backgroundLightMC[100];
final backgroundContainerLight = backgroundLightMC[90];
final onBackgroundContainerLight = backgroundLightMC[10];

final surfaceVariantLightMC =
    MaterialColor(neutralVariant.value, _getSwatch(neutralVariant));
final surfaceVariantLight = surfaceVariantLightMC[40];
final onSurfaceVariantLight = surfaceVariantLightMC[100];
final surfaceVariantContainerLight = surfaceVariantLightMC[90];
final onSurfaceVariantContainerLight = surfaceVariantLightMC[10];

final lightBlueLightMC = MaterialColor(lightBlue.value, _getSwatch(lightBlue));
final lightBlueLight = lightBlueLightMC[40];
final onLightBlueLight = lightBlueLightMC[100];
final lightBlueContainerLight = lightBlueLightMC[90];
final onLightBlueContainerLight = lightBlueLightMC[10];

final lightPurpleLightMC =
    MaterialColor(lightPurple.value, _getSwatch(lightPurple));
final lightPurpleLight = lightPurpleLightMC[40];
final onLightPurpleLight = lightPurpleLightMC[100];
final lightPurpleContainerLight = lightPurpleLightMC[90];
final onLightPurpleContainerLight = lightPurpleLightMC[10];

final surfaceLighMC =
    MaterialColor(surfaceLighMC.value, _getSwatch(surfaceLighMC));
final surfaceLighAt1 = surfaceLigh.withOpacity(0.05);
final surfaceLighAt2 = surfaceLigh.withOpacity(0.08);
final surfaceLighAt3 = surfaceLigh.withOpacity(0.11);
final surfaceLighAt4 = surfaceLigh.withOpacity(0.12);
final surfaceLighAt5 = surfaceLigh.withOpacity(0.14);

// Dark colors
final primaryDarkMC = MaterialColor(primary.value, _getSwatch(primary));
final primaryDark = primaryDarkMC[80];
final onPrimaryDark = primaryDarkMC[20];
final primaryContainerDark = primaryDarkMC[30];
final onPrimaryContainerDark = primaryDarkMC[90];

final secondaryDarkMC = MaterialColor(secondary.value, _getSwatch(secondary));
final secondaryDark = secondaryDarkMC[80];
final onSecondaryDark = secondaryDarkMC[20];
final secondaryContainerDark = secondaryDarkMC[30];
final onSecondaryContainerDark = secondaryDarkMC[90];

final tertiaryDarkMC = MaterialColor(tertiary.value, _getSwatch(tertiary));
final tertiaryDark = tertiaryDarkMC[80];
final onTertiaryDark = tertiaryDarkMC[20];
final tertiaryContainerDark = tertiaryDarkMC[30];
final onTertiaryContainerDark = tertiaryDarkMC[90];

final errorDarkMC = MaterialColor(error.value, _getSwatch(error));
final errorDark = errorDarkMC[80];
final onErrorDark = errorDarkMC[20];
final errorContainerDark = errorDarkMC[30];
final onErrorContainerDark = errorDarkMC[90];

final backgroundDarkMC = MaterialColor(neutral.value, _getSwatch(neutral));
final backgroundDark = backgroundDarkMC[80];
final onBackgroundDark = backgroundDarkMC[20];
final backgroundContainerDark = backgroundDarkMC[30];
final onBackgroundContainerDark = backgroundDarkMC[90];

final surfaceVariantDarkMC =
    MaterialColor(neutralVariant.value, _getSwatch(neutralVariant));
final surfaceVariantDark = surfaceVariantDarkMC[80];
final onSurfaceVariantDark = surfaceVariantDarkMC[20];
final surfaceVariantContainerDark = surfaceVariantDarkMC[30];
final onSurfaceVariantContainerDark = surfaceVariantLightMC[90];

final lightBlueDarkMC = MaterialColor(lightBlue.value, _getSwatch(lightBlue));
final lightBlueDark = lightBlueDarkMC[80];
final onLightBlueDark = lightBlueDarkMC[20];
final lightBlueContainerDark = lightBlueDarkMC[30];
final onLightBlueContainerDark = lightBlueDarkMC[90];

final lightPurpleDarktMC =
    MaterialColor(lightPurple.value, _getSwatch(lightPurple));
final lightPurpleDarkt = lightPurpleDarktMC[80];
final onLightPurpleDarkt = lightPurpleDarktMC[20];
final lightPurpleContainerDark = lightPurpleDarktMC[30];
final onLightPurpleContainerDark = lightPurpleDarktMC[90];

final surfaceDarkAt1 = surfaceDark.withOpacity(0.05);
final surfaceDarkAt2 = surfaceDark.withOpacity(0.08);
final surfaceDarkAt3 = surfaceDark.withOpacity(0.11);
final surfaceDarkAt4 = surfaceDark.withOpacity(0.12);
final surfaceDarkAt5 = surfaceDark.withOpacity(0.14);
