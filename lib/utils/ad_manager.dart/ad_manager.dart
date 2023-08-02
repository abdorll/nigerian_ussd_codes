// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class Admanager extends ChangeNotifier {
//   static BannerAd? _bannerAd;
//   final setBanner = StateProvider<BannerAd?>((_) => _bannerAd);

//   bool _addLoaded = false;

//   late Orientation _currentOrientation;
//   void printer({required String message}) {
//     if (kDebugMode) {
//       print(message);
//     }
//   }

//   Future<void> _loadAd() async {
//     await _bannerAd?.dispose();
//     notifyListeners();
//     _bannerAd = null;
//     _addLoaded = false;

//     _bannerAd = BannerAd(
//         adUnitId: 'ca-app-pub-2573093537524484/9564402040',
//         size: AdSize.banner,
//         request: const AdRequest(),
//         listener: BannerAdListener(onAdLoaded: (Ad ad) {
//             _bannerAd?.dispose();
//           _bannerAd = ad as BannerAd;
//           _addLoaded = true;
//           printer(message: '$ad loaded: ${ad.responseInfo}');
//           notifyListeners();
//         }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           printer(message: "Ad failed to laod");
//         }));

//     return _bannerAd!.load();
//   }

//   void loadBanner(BuildContext context) {
//     _currentOrientation = MediaQuery.of(context).orientation;
//     notifyListeners();
//     _loadAd();
//   }

//   Widget getAdWidget() {
//     return OrientationBuilder(
//       builder: (context, orientation) {
//         printer(message: "seeing.........");

//         if (_currentOrientation == orientation &&
//             _bannerAd != null &&
//             _addLoaded == true) {
//           return Container(
//             color: Colors.green,
//             width: _bannerAd!.size.width.toDouble(),
//             height: _bannerAd!.size.height.toDouble(),
//             child: AdWidget(ad: _bannerAd!),
//           );
//         }
//         if (_currentOrientation != orientation) {
//           _currentOrientation = orientation;
//           _loadAd();
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
