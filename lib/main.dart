import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/data_layer/data_base/receipt_db/receipt_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:foodapp/presentaition_layer/screens/spalsh_screen/splash_screen.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/firebase_options.dart';
import 'package:foodapp/statemanagement/app_providers.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/localization/localization_provider.dart';
import 'package:foodapp/statemanagement/theming/theme_provider.dart';
import 'package:foodapp/statemanagement/withdraw_history/receipt_model.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  
  Hive
    ..registerAdapter(FoodModelAdapter())
    ..registerAdapter(ReceiptModelAdapter());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainWidget());

  SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: Consumer<ThemeProvider>(
        builder: (context, theme, child) {
          return Consumer<LocalizationProvider>(
            builder: (context, locale, child) {
              return ToastificationWrapper(
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  navigatorKey: navigationKey,
                  home: const SplashScreen(),
                  // App Localization
                  locale: locale.getAppLocale,
                  supportedLocales: const <Locale>[
                    Locale("en"),
                    Locale("ar"),
                    Locale("ur"),
                  ],
                  localizationsDelegates: const <LocalizationsDelegate<
                      dynamic>>[
                    CustomLocalizationDelegate.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  localeResolutionCallback: (Locale? deviceLocale,
                      Iterable<Locale> supportedLocales) {
                    for (Locale locale in supportedLocales) {
                      if (deviceLocale != null &&
                          deviceLocale.languageCode == locale.languageCode) {
                        return deviceLocale;
                      }
                    }

                    return supportedLocales.first;
                  },
                  // App Thame
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: const Color(0xFFFF785B),
                      brightness: theme.getAppTheme,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
