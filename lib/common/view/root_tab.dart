import 'package:flutter/material.dart';
import 'package:flutter_level_2/common/const/color.dart';
import 'package:flutter_level_2/common/layout/default_layout.dart';
import 'package:flutter_level_2/order/view/order_screen.dart';

import 'package:flutter_level_2/product/view/procuct_screen.dart';
import 'package:flutter_level_2/user/view/profile_screen.dart';

import '../../restaurant/view/restaurant_screen.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';

  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        type: BottomNavigationBarType.shifting,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.fastfood_outlined,
              ),
              label: '음식'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.receipt_long_outlined,
              ),
              label: '주문서'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outlined,
              ),
              label: '프로필'),
        ],
      ),
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          Center(
            child: Container(
              child: const RestaurantScreen(),
            ),
          ),
          const Center(
            child: ProductScreen(),
          ),
          const OrderScreen(),
          const ProfileScreen()
        ],
      ),
    );
  }
}
