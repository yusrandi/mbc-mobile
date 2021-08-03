import 'package:flutter/material.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';

class CardHomePeternak extends StatelessWidget {
  const CardHomePeternak({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              height: 150,
              width: 250,
              margin: EdgeInsets.only(right: 8),
              child: Stack(
                children: [
                  Positioned(
                      top: 50,
                      bottom: 20,
                      left: 20,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.only(left: 80),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Nama Peternak",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            
                          ],
                        ),
                      )),
                  Positioned(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      child: Image.asset(Images.farmImage, height: 200,)),
                ],
              ),
            );
          }),
    );
  }
}
