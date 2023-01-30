import 'package:flutter/material.dart';
import 'package:weather_good/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
//
class BannerInlinePage extends StatefulWidget {
  const BannerInlinePage({Key? key}) : super(key: key);

  @override
  State<BannerInlinePage> createState() => _BannerInlinePageState();
}

class _BannerInlinePageState extends State<BannerInlinePage> {
  // TODO: Add _kAdIndex
  static final _kAdIndex = 4;

  // TODO: Add a banner ad instance
  BannerAd? _ad;

  // TODO: Add _getDestinationItemIndex()
  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _ad != null) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  @override
  void initState() {
    super.initState();
    // TODO: Load a banner ad
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AdWidget(ad: _ad!),
      width: _ad!.size.width.toDouble(),
      height: 50,
      alignment: Alignment.bottomCenter,
    );
  }
}
