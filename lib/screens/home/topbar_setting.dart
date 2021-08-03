import 'package:flutter/material.dart';
import 'package:mbc_mobile/utils/images.dart';

class TopbarSetting extends StatelessWidget {
  const TopbarSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Image.asset(Images.logoImage, width: 35),
            SizedBox(width: 16),
            Text('Hello, use run D',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          ],),
          Icon(Icons.settings, color: Colors.white)
        ],
      ),
    );
  }
}
