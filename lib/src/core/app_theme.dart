import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppTheme {
  static ThemeData get darkTheme => ThemeData(
        primarySwatch: Colors.lightBlue,
        scaffoldBackgroundColor: Color(0xFF030712),
        brightness: Brightness.light,
        dividerColor: Colors.white54,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 72.0,
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontSize: 36.0,
            color: Colors.white,
          ),
          headlineSmall: TextStyle(
            fontSize: 24.0,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Hind',
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Hind',
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            fontSize: 12.0,
            fontFamily: 'Hind',
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontSize: 24.0,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
          titleSmall: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          elevation: 3,
          backgroundColor: Color(0xFF1F2937).withOpacity(0.6),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        cardTheme: CardTheme(
          color: Color(0xFF030712).withOpacity(0.6),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          prefixIconColor: Colors.white,
          suffixIconColor: Colors.white,
          hintStyle: TextStyle(color: Colors.white),
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: const TextStyle(color: Colors.white),
          ),
          menuStyle: MenuStyle(
            backgroundColor:
                MaterialStateProperty.all(Color.fromRGBO(27, 35, 46, 1)),
          ),
          textStyle: const TextStyle(color: Colors.white),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(Colors.white),
          checkColor: MaterialStateProperty.all(Colors.black),
        ),
      );

  static ThemeData get lightTheme => ThemeData(
        primarySwatch: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        dividerColor: Colors.black54,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headlineMedium: TextStyle(
            fontSize: 36.0,
            fontStyle: FontStyle.italic,
            color: Colors.black,
          ),
          headlineSmall: TextStyle(
            fontSize: 24.0,
            color: Colors.black,
          ),
          bodyLarge: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Hind',
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Hind',
            color: Colors.black,
          ),
          bodySmall: TextStyle(
            fontSize: 12.0,
            fontFamily: 'Hind',
            color: Colors.black,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade300,
          titleTextStyle: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
          elevation: 3,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          prefixIconColor: Colors.black,
          suffixIconColor: Colors.black,
          hintStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(Colors.black),
          checkColor: MaterialStateProperty.all(Colors.white),
        ),
      );
}
