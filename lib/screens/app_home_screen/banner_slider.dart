import 'package:asset_app/api/Networking/network.dart';
import 'package:asset_app/api/modal/banner_modal_class.dart';
import 'package:asset_app/api/utility/app_url.dart';
import 'package:flutter/material.dart';
import 'package:banner_carousel/banner_carousel.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({Key key}) : super(key: key);

  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  List<BannerModel> createBanners(BannersModal banners) {
    List<BannerModel> baners = [];
    for (int i = 0; i < banners.data.length; ++i) {
      baners.add(BannerModel(
          imagePath: banners.data[i].image,
          id: banners.data[i].id,
          boxFit: BoxFit.cover));
    }
    return baners;
  }

  Future<dynamic> dataString;
  @override
  void initState() {
    super.initState();
    dataString = Network(AppUrl.bannerSlider).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dataString,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            BannersModal banners = bannersModalFromJson(snapshot.data);
            // print(banners.data.toString());
            return BannerCarousel(
              height: 200,
              banners: createBanners(banners),
              onTap: (id) => print(id),
              width: MediaQuery.of(context).size.width,
            );
          }
          return Container();
          // return Center(
          //   child: CircularProgressIndicator(),
          // );
        });
  }
}
