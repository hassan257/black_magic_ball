
import 'package:admob_widgets/admob_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/widgets.dart' show BolaNegra;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AdMobWidgets.instance(
      androidBannerAdUnitId: "ca-app-pub-6473425324446369/3099227048",
      androidInterstitialAdUnitId: "ca-app-pub-6473425324446369/5248717979");
  await MobileAds.instance.initialize();
  // Para inhabilitar el cambio de orientación
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: const [_PrivacyButton()],
        ),
        body: const _Body(),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? appLocalizations = AppLocalizations.of(context);
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            appLocalizations!.askYourQuestion,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
                fontSize: 40),
          ),
          const Spacer(),
          BolaNegra(
            respuestas: [
              appLocalizations.dontGiveUp,
              appLocalizations.everythingIsGoingToBeOk,
              appLocalizations.followYourDreams,
              appLocalizations.iDontThinkSo,
              appLocalizations.maybeInAFuture,
              appLocalizations.probablyYes,
              appLocalizations.yourLuckIsAboutToChange
            ],
            thinking: appLocalizations.thinking,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.info,
                color: Colors.redAccent,
              ),
              Text(
                appLocalizations.tapOrDragTheCenterToGetAnAnswer,
                style: const TextStyle(
                    color: Colors.redAccent, fontWeight: FontWeight.w600),
              )
            ],
          ),
          const Spacer(),
          const BannerWidget()
        ],
      ),
    );
  }
}

class _PrivacyButton extends StatelessWidget {
  const _PrivacyButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () async {
          const url =
              'https://cuudevs.com/src/privacidad/privacidad_black_magic_ball.html';
          final Uri url0 = Uri.parse(url);
          if (await canLaunchUrl(url0)) {
            await launchUrl(url0, mode: LaunchMode.externalApplication);
          }
        },
        child: const Icon(
          Icons.privacy_tip,
          color: Colors.black26,
        ),
      ),
    );
  }
}
