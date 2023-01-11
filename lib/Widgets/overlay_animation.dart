import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_plate_app/getController.dart';

class OverlayAnimation extends StatelessWidget {

  final VoidCallback onTap;

  OverlayAnimation({super.key, required this.onTap});

  final FoodController ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: 60,
        width: size.width - 40,
        decoration:  BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.5),
              offset: const Offset(1.0, 1.0),
              blurRadius: 1.0,
              spreadRadius: 1.0
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<FoodController>(
                  builder: (_) => Text('${ctrl.index.value} selected',style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),),
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue
                  ),
                  child: const Icon(Icons.arrow_right_alt_outlined, color: Colors.white, size: 20,),
                ),
              )
            ],
          ),
        ),
    );
  }
}
