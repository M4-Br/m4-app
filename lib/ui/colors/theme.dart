import 'package:flutter/material.dart';

//Tema Light
ThemeData lightMode = ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: primaryColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(45),
                                ),
                        ),
                        backgroundColor: WidgetStateProperty.all(secondaryColor),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        textStyle: WidgetStateProperty.all(
                                const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                ),
        ),
        progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: secondaryColor),
        dividerTheme: DividerThemeData(color: Colors.grey.shade400),
        cardTheme: CardTheme(
                color: Colors.grey.shade100,
                shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                ),
        ),
        colorScheme: ColorScheme.light(
                surface: Colors.grey.shade300,
                primary: Colors.grey.shade200,
                secondary: secondaryColor,
                tertiary: Colors.grey.shade100,
        ),
        appBarTheme: const AppBarTheme(
                color: primaryColor,
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
                centerTitle: true,
                elevation: 0,
        ),
        inputDecorationTheme: const InputDecorationTheme(
                floatingLabelStyle: TextStyle(color: secondaryColor, fontSize: 18),
                isDense: true,
                contentPadding: EdgeInsets.zero,
                labelStyle: TextStyle(fontSize: 18),
                focusColor: secondaryColor,
                border: InputBorder.none,
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide()),
                focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                ),
                errorBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                errorStyle: TextStyle(color: Colors.red),
        ),
        textTheme: const TextTheme(
                bodySmall: TextStyle(fontSize: 16),
                bodyMedium: TextStyle(fontSize: 17),
                bodyLarge: TextStyle(fontSize: 18),
                displaySmall: TextStyle(fontSize: 16),
                displayMedium: TextStyle(fontSize: 17),
                displayLarge: TextStyle(fontSize: 18),
                labelSmall: TextStyle(fontSize: 16),
                labelMedium: TextStyle(fontSize: 17),
                labelLarge: TextStyle(fontSize: 18),
                headlineSmall: TextStyle(fontSize: 16),
                headlineMedium: TextStyle(fontSize: 17),
                headlineLarge: TextStyle(fontSize: 18),
        ),
);



//Tema Dark
ThemeData darkMode = ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(45),
                                ),
                        ),
                        backgroundColor: WidgetStateProperty.all(secondaryColor),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        textStyle: WidgetStateProperty.all(
                                const TextStyle(fontSize: 20),
                        ),
                ),
        ),
        progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: secondaryColor),
        dividerTheme: DividerThemeData(color: Colors.grey.shade800),
        cardTheme: CardTheme(
                color: Colors.grey.shade700,
                shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                ),
        ),
        colorScheme: ColorScheme.dark(
                surface: Colors.grey.shade800,
                primary: Colors.grey.shade700,
                secondary: Colors.grey.shade100,
                tertiary: Colors.grey.shade500,
        ),
        appBarTheme: const AppBarTheme(
            color: primaryColor,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
            centerTitle: true,
            elevation: 0),
        inputDecorationTheme: const InputDecorationTheme(
                floatingLabelStyle: TextStyle(color: secondaryColor, fontSize: 18),
                isDense: true,
                labelStyle: TextStyle(
                        fontSize: 18,
                ),
                focusColor: secondaryColor,
                border: InputBorder.none,
                enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                ),
                errorBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                errorStyle: TextStyle(color: Colors.red),
        ),
        textTheme: const TextTheme(
                bodySmall: TextStyle(fontSize: 14),
                bodyMedium: TextStyle(fontSize: 15),
                bodyLarge: TextStyle(fontSize: 16),
                displaySmall: TextStyle(fontSize: 14),
                displayMedium: TextStyle(fontSize: 15),
                displayLarge: TextStyle(fontSize: 16),
                labelSmall: TextStyle(fontSize: 14),
                labelMedium: TextStyle(fontSize: 15),
                labelLarge: TextStyle(fontSize: 16),
        ),
);

const Color primaryColor = Color(0xFF002A4D);
const Color secondaryColor = Color(0xFFB4520C);
const Color thirdColor = Color(0xFF021B30);

const Color defaultButtonColor = Color(0xFFB4520C);
const Color defaultColorText = Color(0xFF424242);
const Color defaultBoldColorText = Color(0xFF6A6A6A);
const Color btnNegativeColor = Color(0xFFCD5050);
const Color disabledButtonColor = Color(0xFFDCDBDB);
const Color negativeButtonColor = Color(0xFFCD5050);
const Color neutralButtonColor = Color(0xFFDCDBDB);
const Color lightGrey = Color(0xFFf8f8f8);
const Color lightGrey2 = Color(0xFFfcfcfc);
const Color darkGrey = Color(0xFFECECEC);
const Color colorWhatsApp = Color(0xFF26D367);
const Color colorEmail = Color(0xFFCC3731);
const Color colorOther = Color(0xFF590D0D);
const Color colorBack = Color(0xFF707070);
const Color colorTextRegister = Color(0xFF9395A3);
const Color colorLineRegister = Color(0xFF8E90A5);
const Color colorTextInvalid = Color(0xFFE02121);
const Color colorTextHint = Color(0xFFCCCCCC);
const Color colorGrey = Color(0xFFf7f7f7);
const Color subtitle = Color(0xFF8b8383);
const Color disabledTitle = Color(0xFFA0A0A0);
const Color darkGray = Color(0xFF313131);
const Color colorGreyCard = Color(0xFFF6F6F6);
const Color colorBackgroundPayment = Color(0xFFF7F5F5);
const Color colorLine = Color(0xFFE1DDFD);
const Color colorRed = Color(0xFFE02121);
const Color white = Color(0xFFFFFFFF);
const Color bgHomePix = Color(0xFFf9f9f9);
const Color viewFinderMask = Color(0x60000000); // Semi-transparent black
const Color calendarBlack = Color(0xFF000000);
const Color calendarGrey = Color(0xFF474747);
const Color calendarGreen = Color(0xFF008489);
const Color calendarGreyPast = Color(0xFFBEBEBE);
const Color extractValueColor = Color(0xFF1E367F);
const Color vivoColor = Color(0xFF68019a);
const Color timColor = Color(0xFF00378a);
const Color oiColor = Color(0xFFFFCC33);
const Color claroColor = Color(0xFFe12f20);
const Color dateColor = Color(0xFFd78d6c);
const Color receivementItemFilter = Color(0xFF93a5d9);
const Color receivementItemFilterSelected = Color(0xFF293762);
const Color scheduleBlue = Color(0xFF3552AA);
const Color scheduleGreen = Color(0xFF35AA64);
const Color scheduleOrange = Color(0xFFD78D6C);
const Color scheduleRed = Color(0xFFAA3535);
const Color groupItemDesc = Color(0xFF888282);
const Color btn = Color(0xFFEAEAEA);
const Color grey100 = Color(0xFFF5F5F5);
const Color grey110 = Color(0xFF888282);
const Color grey120 = Color(0xFFEAEAEA);
