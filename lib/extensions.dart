import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

extension HumanTime on DateTime {
  String get inRoughTime {
    timeago.setLocaleMessages('en', CustomHumanTimeMessages());
    return timeago.format(this, allowFromNow: true);
  }
}

extension HumanDuration on Duration {
  String get inRoughTime {
    final seconds = inSeconds % 60;
    final minutes = inSeconds / 60;
    final hours = minutes / 60;
    return '$hours $minutes: $seconds';
  }
}

class CustomHumanTimeMessages implements timeago.LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => 'remaining';
  @override
  String lessThanOneMinute(int seconds) => 'now';
  @override
  String aboutAMinute(int minutes) => '${minutes}m';
  @override
  String minutes(int minutes) => '${minutes}m';
  @override
  String aboutAnHour(int minutes) => '${minutes}m';
  @override
  String hours(int hours) => '${hours}h';
  @override
  String aDay(int hours) => '${hours}h';
  @override
  String days(int days) => '${days}d';
  @override
  String aboutAMonth(int days) => '${days}d';
  @override
  String months(int months) => '${months}mo';
  @override
  String aboutAYear(int year) => '${year}y';
  @override
  String years(int years) => '${years}y';
  @override
  String wordSeparator() => ' ';
}

String getInitials(String text) {
  if (text.isEmpty) return '';

  List<String> words = text.trim().split(' ');
  if (words.length >= 2) {
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  } else {
    return text.substring(0, text.length >= 2 ? 2 : text.length).toUpperCase();
  }
}

extension OnColorGenerator on Color {
  Color get onColor {
    const double requiredContrastRatio = 4.5;

    // Calculate the relative luminance of the background color.
    double backgroundLuminance = computeLuminance();

    // Function to calculate contrast ratio between two luminances.
    double calculateContrast(double luminance1, double luminance2) {
      return luminance1 > luminance2
          ? (luminance1 + 0.05) / (luminance2 + 0.05)
          : (luminance2 + 0.05) / (luminance1 + 0.05);
    }

    // Function to adjust the color towards white or black until sufficient
    // contrast is achieved.
    Color adjustColor(Color color, double targetLuminance) {
      // Create HSLColor from the input color
      HSLColor hslColor = HSLColor.fromColor(color);

      // Adjust the lightness towards the target luminance
      hslColor = hslColor.withLightness(targetLuminance);

      // Convert back to Color
      return hslColor.toColor();
    }

    // Determine whether we need to lighten or darken the color.
    if (backgroundLuminance > 0.5) {
      // Darken the color
      double targetLuminance = 0.0;
      while (calculateContrast(backgroundLuminance, targetLuminance) <
              requiredContrastRatio &&
          targetLuminance < 1.0) {
        targetLuminance += 0.01;
      }
      return adjustColor(this, targetLuminance);
    } else {
      // Lighten the color
      double targetLuminance = 1.0;
      while (calculateContrast(backgroundLuminance, targetLuminance) <
              requiredContrastRatio &&
          targetLuminance > 0.0) {
        targetLuminance -= 0.01;
      }
      return adjustColor(this, targetLuminance);
    }
  }
}
