import 'package:cwt_ecommerce_ui_kit/utils/constants/text_strings.dart';
import 'package:cwt_ecommerce_ui_kit/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/general_bindings.dart';
import 'utils/constants/colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: TTexts.appName,
        themeMode: ThemeMode.system,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        initialBinding: GeneralBindings(),
        home: const Scaffold(
            backgroundColor: TColors.primary,
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )))
        // home: const OnBoardingScreen(),
        );
  }
}
