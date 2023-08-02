import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ussd_bank_codes/utils/constants/constants.dart';
import 'package:ussd_bank_codes/widget/textts.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class BannerAdMobContainer extends StatefulWidget {
  const BannerAdMobContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<BannerAdMobContainer> createState() => _BannerAdMobContainerState();
}

class _BannerAdMobContainerState extends State<BannerAdMobContainer> {
  InternetStatus? _connectionStatus;
  late StreamSubscription<InternetStatus> _subscription;
  BannerAd? bannerAd;

  bool isLoaded = false;
  //-------------------------------------------

  @override
  void initState() {
    super.initState();
    _subscription = InternetConnection().onStatusChange.listen((status) {
      setState(() {
        _connectionStatus = status;
      });
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   loadAd();
    // });
    // super.initState();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadAd();
    });
    super.didChangeDependencies();
  }

  //-------------------------------------------
  @override
  void dispose() {
    _subscription.cancel();
    if (bannerAd != null) {
      bannerAd!.dispose();
    }
    super.dispose();
  }

  //-------------------------------------------
  @override
  Widget build(BuildContext context) {
    if (!isLoaded || bannerAd == null) {
      loadAd();
    }
    if (_connectionStatus == InternetStatus.connected &&
        (isLoaded || bannerAd != null)) {
      return SizedBox(
        width: double.infinity, //this is for giving infinite width
        height: bannerAd!.size.height.toDouble(),
        child: AdWidget(
          ad: bannerAd!,
        ),
      );
    } else if (_connectionStatus == InternetStatus.disconnected) {
      return SizedBox(
        height: 20,
        width: double.infinity,
        child: Container(
          decoration: const BoxDecoration(color: Colors.red),
          child: Center(
            child: TextOf(
              text: "Somethings are wrong!",
              size: 12,
              weight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
    // return !isLoaded || bannerAd == null
    //     ?
    //     :
  }

  //-------------------------------------------
  void loadAd() async {
    if (kDebugMode) {
      print("loadAd: load ad one 1");
    }
    if (isLoaded || bannerAd != null) {
      return;
    }
    if (kDebugMode) {
      print("loadAd: load ad 2 bannerAdSize");
    }

    final AnchoredAdaptiveBannerAdSize? bannerAdSize =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      MediaQuery.of(context).size.width.truncate(),
    );
    if (kDebugMode) {
      print("loadAd: load ad 3 bannerAdSize");
    }
    bannerAd = BannerAd(
      adUnitId: Constants.bannerAdUnit,
      request: const AdRequest(),
      size: bannerAdSize!,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          //this isLoaded booleans are important to display ads dont ever remove it
          setState(() {
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          //this isLoaded booleans are important to display ads dont ever remove it
          setState(() {
            isLoaded = false;
          });
          ad.dispose();
        },
      ),
    )..load();
    if (kDebugMode) {
      print("loadAd: load ad one bannerAdSize loaded");
    }
  }
}
