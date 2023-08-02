// ignore_for_file: prefer_const_constructors

// import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ussd_bank_codes/utils/constants/constants.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:google_mobile_ads_manager/google_mobile_ads_manager.dart';
import 'package:ussd_bank_codes/utils/image_paths.dart/image_path.dart';
import 'package:ussd_bank_codes/views/banks_screen/banks_screen.dart';
import 'package:ussd_bank_codes/views/network_display_screen/network_display_screen.dart';
import 'package:ussd_bank_codes/widget/banner_ad.dart';
import 'package:ussd_bank_codes/widget/textts.dart';

// ignore_for_file: public_member_api_docs
class HomeScreen extends StatefulWidget {
  static const String homeScreen = '/homeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int recognised = 0;
  InterstitialAd? _interstitialAd;

  @override
  void didChangeDependencies() {
    WidgetsFlutterBinding.ensureInitialized();
    MobileAds.instance.initialize();
    super.didChangeDependencies();
    _loadAd();
  }

  // @override
  // void initState() {
  //   _interstitialAd?.show();
  //   super.initState();
  // }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  int currentIndex = 0;
  List<Widget> bodyItems = [NetworkScreen(), BanksOptionListScreen()];
  List<String> imageNames = [ImageName.homeIcon, ImageName.bankIcon];
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _interstitialAd?.show());
    return Scaffold(
      body: bodyItems[currentIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomAppBar(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 20,
            shape: const CircularNotchedRectangle(),
            notchMargin: 1,
            height: 70,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  navIcon(
                      id: 0, icon: ImageName.homeIcon, text: "Home", extra: -3),
                  navIcon(id: 1, icon: ImageName.bankIcon, text: "Banks"),
                ]),
          ),
          BannerAdMobContainer()
          // AdWidget(ad: ad.getAd()),
        ],
      ),
    );
  }

  navIcon({int? id, required String icon, String? text, double? extra}) {
    Color color =
        currentIndex == id ? Colors.green : Colors.grey.withOpacity(0.9);
    return ElevatedButton(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          elevation: MaterialStateProperty.all<double>(0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageIcon(
                AssetImage(
                  icon,
                ),
                size: 23 + (extra ?? 0),
                color: color),
            const SizedBox(height: 1),
            TextOf(
              text: text!,
              size: 10,
              color: color,
            )
          ],
        ),
        onPressed: () {
          setState(() {
            currentIndex = id!;
          });
        });
  }

  void _loadAd() {
    InterstitialAd.load(
        adUnitId: Constants.interstatAdUnit,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (InterstitialAd ad) {
            if (kDebugMode) {
              print("trying loaded InterstitialAd");
            }
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});
            // Keep a reference to the ad so you can show it later.
            setState(() {
              _interstitialAd = ad;
            });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            // ignore: avoid_print
            print('InterstitialAd failed to load: $error');
          },
        ));
  }
}
