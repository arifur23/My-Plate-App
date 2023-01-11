import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getController.dart';

class FoodBox extends StatefulWidget {
  final String name;
  final String calories;
  final Color foodBGColors;
  final String imageUrl;
  final bool isSelected;
  final Function(Offset offset)? onTap;
  final Function(Offset offset)? secondary;
  const FoodBox({super.key, required this.name, required this.calories, required this.foodBGColors, required this.imageUrl, required this.isSelected, required this.onTap, this.secondary});



  @override
  State<FoodBox> createState() => _FoodBoxState();
}


class _FoodBoxState extends State<FoodBox> {

  final controller = Get.put(FoodController());

  bool isChange = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: widget.foodBGColors
                ),
                child: Center(
                  child: Container(
                    height: 40,
                      width: 40,
                      child: Image.asset(widget.imageUrl, fit: BoxFit.cover,)
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black.withOpacity(.6)),),
                  const SizedBox(height: 7,),
                  Text(widget.calories, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black.withOpacity(.4)),)
                ],
              )
            ],
          ),
           GetBuilder<FoodController>(
               builder: (_) => GestureDetector(
                 onTap: (){

                   setState(() {
                     RenderBox? box = context.findRenderObject() as RenderBox;
                     Offset offset = box.localToGlobal(Offset.zero);

                     if(controller.showOverlay.value == true){
                       widget.onTap!(offset);
                       controller.changeOverlay();
                     }
                     else{
                       isChange ? print('') : widget.secondary!(offset);
                     }
                     isChange ? controller.decreaseIndex() : controller.increaseIndex();
                     isChange = !isChange;
                   });
                 },
                 child: Container(
                   height: 35,
                   width: 35,
                   decoration: BoxDecoration(
                     color: isChange ? Colors.deepPurple : Colors.white,
                       borderRadius: BorderRadius.circular(50),
                       border: Border.all(color: Colors.black.withOpacity(.5),width: 2)
                   ),
                   child: Center(
                     child: Icon(isChange ? Icons.check : Icons.add, size: 20, color: isChange ? Colors.white : Colors.black.withOpacity(.4),),
                   ),
                 ),
               )
           )
        ],
      ),
    );
  }
}
