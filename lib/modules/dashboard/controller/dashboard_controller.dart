import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getHomePageData();
  }
  int count = 0;
  final ScrollController scrollController = ScrollController();


  getHomePageData() async {}
  RxBool hideTitle = true.obs;
  RxInt bottomNavIndex = 0.obs;

  bottomNavPressed(index) async {
    bottomNavIndex.value = index;
    update();
  }
}
