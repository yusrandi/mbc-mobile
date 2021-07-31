import 'package:flutter/material.dart';
import 'package:mbc_mobile/screens/home/body.dart';
import 'package:mbc_mobile/screens/home/home_topbar_menu.dart';
import 'package:mbc_mobile/screens/home/screen/home_screen_home.dart';
import 'package:mbc_mobile/screens/home/screen/home_screen_todo.dart';
import 'package:mbc_mobile/screens/home/topbar_setting.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class HomeTopbar extends StatefulWidget {
  const HomeTopbar({Key? key}) : super(key: key);

  @override
  _HomeTopbarState createState() => _HomeTopbarState();
}

class _HomeTopbarState extends State<HomeTopbar> {

  int _currentIndex = 0;
  int getIndex() => this._currentIndex;

  @override
  Widget build(BuildContext context) {

   return Column(
     children: [
       Container(
         decoration: BoxDecoration(color: kBackgroundColor),
         height: SizeConfig.screenHeight/2.5,
         child: Stack(
            children: [
              Positioned(child: Container(
                margin: EdgeInsets.symmetric(horizontal: 26),
                decoration: BoxDecoration(color: Colors.white),
              )),
             Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Expanded(
                     flex: 1,
                     child: GestureDetector(onTap: (){
                       setState(() {
                         _currentIndex = 0;

                       });
                     }, child: HomeTopbarMenu(state: 0, currentState: _currentIndex, title: 'Home',))
                 ),
                 Expanded(
                     flex: 1,
                     child: GestureDetector(onTap: (){
                       setState(() {
                         _currentIndex = 1;
                       });
                     }, child: HomeTopbarMenu(state: 1, currentState: _currentIndex, title: 'Todo',))
                 ),
               ],
             ),
             Positioned(
               top: 0,
               left: 0,
               right: 0,
               bottom: 60,
               child: Container(
                 padding: EdgeInsets.only(top: getProportionateScreenHeight(16)),
                 decoration: BoxDecoration(
                     color: kPrimaryColor,
                     borderRadius:
                     BorderRadius.vertical(bottom: Radius.circular(25))),
                 child: Stack(
                   children: [
                      TopbarSetting(),
                      Center(child: Text('What your focus main \ntoday ?', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold))),
                      Positioned(
                        bottom: 30,
                        left: 0,
                        right: 0,
                        child: Container(
                         padding: EdgeInsets.only(left: 36),
                         child: Row(
                           children: [
                             Expanded(
                               flex: 3,
                               child: Container(
                                 height: 50,
                                 decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(35)
                                 ),
                                 child: Center(child: Text('hahahhaha')),
                               ),
                             ),
                             SizedBox(width: 16,),
                             Expanded(
                               flex: 1,
                               child: Container(
                                 height: 50,
                                 decoration: BoxDecoration(
                                     color: Colors.black,
                                     borderRadius: BorderRadius.horizontal(left: Radius.circular(35))
                                 ),
                                 child: Icon(Icons.settings, color: Colors.white),

                               ),
                             )
                           ],
                         ),
                     ),
                      ),
                   ],
                 ),

               ),
             ),
           ],
         ),
       ),

       Container(
         margin: EdgeInsets.all(16),
         child: _currentIndex == 0 ? HomeScreenHome() : HomeScreenTodo(),
       ),
     ],
   );
  }
}
