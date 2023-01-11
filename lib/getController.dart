import 'package:get/get.dart';

class FoodController extends GetxController{
  var index = 0.obs;
  var showOverlay = true.obs;

  increaseIndex(){
    index++;
    update();
  }

  decreaseIndex(){
    index--;
    update();
  }

  changeOverlay(){
    showOverlay.value = !showOverlay.value;
    update();
  }
}