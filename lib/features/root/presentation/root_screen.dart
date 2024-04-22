
import 'package:crypto_currency_test/features/home/presentation/home_screen.dart';
import 'package:crypto_currency_test/features/trading/presentation/trading_screen.dart';
import 'package:crypto_currency_test/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
class RootUiController extends GetxController{
  var pageController=PageController();
  var currentIndex=0.obs;
  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
final currentIndexProvider=StateProvider((ref) => 0);
class RootScreen extends StatelessWidget {
  RootScreen({super.key});
final controller=Get.put(RootUiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          TradingScreen(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(child: 
      Obx(
        () {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                 
                  controller.currentIndex.value=0;
                  controller.pageController.previousPage(duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
                  
                },
                child: SvgPicture.asset("assets/svg/dashboard.svg",
                color: controller.currentIndex.value==0?primaryColor:Colors.grey,
                )),
              InkWell(
                onTap: (){
                
                  controller.currentIndex.value=1;
                  controller.pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
                },
                child: SvgPicture.asset("assets/svg/trading.svg",color: controller.currentIndex.value==1?primaryColor:Colors.grey,)),
            ],
          );
        }
      )),
    );
  }
}