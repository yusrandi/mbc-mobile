import 'package:flutter/material.dart';
import 'package:mbc_mobile/screens/home/home_card.dart';
import 'package:mbc_mobile/screens/home/home_menu_card.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class HomeScreenHome extends StatelessWidget {
  const HomeScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: SizeConfig.screenWidth,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(colors: [
              kPrimaryColor,
              Colors.green.shade100,
            ]),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Have u done your progress today ?",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
              ),
              Expanded(child: Image.asset(Images.farmerImage)),
            ],
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(16),
        ),
        
        Padding(
          padding: EdgeInsets.only(left: 16, bottom: 16),
          child: Text("Featured Service",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        HomeMenuCard(),
        Padding(
          padding: EdgeInsets.only(left: 16, bottom: 16),
          child: Text("Farmer",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        CardHomePeternak(),
      ],
    ));
  }

  void gotoAnotherPage(String route, BuildContext context) {

    Navigator.pushNamed(context, route);

  }
}

class CategoryTab extends StatelessWidget {
  final IconData icon;
  final String title;

  CategoryTab({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green[100]),
            child: Icon(
              icon,
              color: kSecondaryColor,
            ),
          ),
          Text(title,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
        ],
      ),
    );
  }
}
