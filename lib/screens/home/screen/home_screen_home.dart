import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbc_mobile/screens/home/home_card.dart';
import 'package:mbc_mobile/screens/home/home_menu_card.dart';
import 'package:mbc_mobile/screens/insiminasi_buatan/insiminasi_buatan_screen.dart';
import 'package:mbc_mobile/screens/performa/performa_screen.dart';
import 'package:mbc_mobile/screens/periksa_kebuntingan/periksa_kebuntingan_screen.dart';
import 'package:mbc_mobile/screens/peternak/peternak_screen.dart';
import 'package:mbc_mobile/screens/strow/strow_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class HomeScreenHome extends StatelessWidget {
  final int userId;
  const HomeScreenHome({Key? key, required this.userId}) : super(key: key);

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
        // HomeMenuCard(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () => gotoAnotherPage(PeternakScreen(userId: userId), context),
                        child: homeMenu(Icons.category, "Peternak"))),
                Expanded(
                    child: GestureDetector(
                        onTap: () => gotoAnotherPage(PeriksaKebuntinganScreen(), context),
                        child: homeMenu(FontAwesomeIcons.box, "PKB"))),
                Expanded(
                    child: GestureDetector(
                        onTap: () => gotoAnotherPage(StrowScreen(), context),
                        child: homeMenu(Icons.folder, "Strow"))),
                Expanded(
                    child: GestureDetector(
                        onTap: () => gotoAnotherPage(PerformaScreen(), context),
                        child: homeMenu(Icons.category, "Performa"))),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () => gotoAnotherPage(InsiminasiBuatanScreen(), context),
                        child: homeMenu(Icons.archive, "IB"))),
                Expanded(
                    child: GestureDetector(
                        onTap: () => gotoAnotherPage(PeriksaKebuntinganScreen(), context),
                        child: homeMenu(FontAwesomeIcons.bookReader, "Perlakuan"))),
                Expanded(child: Container()),
                Expanded(child: Container()),
                
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, bottom: 16),
          child: Text("Farmer",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        CardHomePeternak(userId: userId),
      ],
    ));
  }

  void gotoAnotherPage(Widget landingPage, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return landingPage;
    }));
  }

  Widget homeMenu(IconData icon, String title) {
    return Container(
      height: 80,
      child: Container(
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
      ),
    );
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
