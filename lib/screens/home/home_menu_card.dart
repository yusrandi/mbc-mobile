import 'package:flutter/material.dart';
import 'package:mbc_mobile/screens/home/data/home_menu_data.dart';
import 'package:mbc_mobile/utils/constants.dart';
class HomeMenuCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: HomeMenuData.listItems.length,
          itemBuilder: (context, index) {
            HomeMenuData menu = HomeMenuData.listItems[index];

            return GestureDetector(
              onTap: () {
                
                Navigator.pushNamed(context, menu.route);

              },
              child: Container(
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
                        menu.icon,
                        color: kSecondaryColor,
                      ),
                    ),
                    Text(menu.title,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14)),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
