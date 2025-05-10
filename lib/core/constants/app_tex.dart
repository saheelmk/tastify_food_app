import 'package:flutter/material.dart';

class AppText {
  AppText._();

  // Headings
  static Widget headingSmall(
    BuildContext context,
    String text, {
    TextAlign? align,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: color ?? Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  static Widget heading(
    BuildContext context,
    String text, {
    TextAlign? align,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: color ?? Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  static Widget headingLarge(
    BuildContext context,
    String text, {
    TextAlign? align,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: color ?? Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  // Body Texts
  static Widget bodySmall(
    BuildContext context,
    String text, {
    TextAlign? align,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: color ?? Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  static Widget body(
    BuildContext context,
    String text, {
    TextAlign? align,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
        color: color ?? Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  static Widget bodyLarge(
    BuildContext context,
    String text, {
    TextAlign? align,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
        color: color ?? Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  // Captions
  static Widget captionSmall(String text, {TextAlign? align, Color? color}) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w400,
        color: color ?? Colors.grey,
      ),
    );
  }

  static Widget caption(String text, {TextAlign? align, Color? color}) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        color: color ?? Colors.grey,
      ),
    );
  }

  static Widget captionLarge(String text, {TextAlign? align, Color? color}) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: color ?? Colors.grey,
      ),
    );
  }
}
