import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_plate_app/Screens/home_screen.dart';
import 'package:my_plate_app/Screens/schedule_screen.dart';
import 'package:my_plate_app/Widgets/food_box.dart';
import 'package:my_plate_app/Widgets/overlay_animation.dart';
import 'package:my_plate_app/Widgets/secondary_overlay.dart';
import 'package:my_plate_app/getController.dart';

class AddToPlateScreen extends StatefulWidget {
  const AddToPlateScreen({Key? key}) : super(key: key);

  @override
  State<AddToPlateScreen> createState() => _AddToPlateScreenState();
}

class _AddToPlateScreenState extends State<AddToPlateScreen> with TickerProviderStateMixin{

  final controller = Get.put(FoodController());
  late AnimationController animationController;
  late List<Animation<double>> animations;

  late AnimationController overlayAnimationController;
  late AnimationController secondaryOverlayAnimationController;

  List<Food> foodListClass = [
    Food(name: 'Pizza', backgroundColor: Colors.blue, imageUrl: 'images/pizza.png', calories: '102 calories', isSelected: false),
    Food(name: 'Bananas', backgroundColor: Colors.lightBlueAccent, imageUrl: 'images/banana.png', calories: '102 calories', isSelected: false),
    Food(name: 'White rice', backgroundColor: Colors.deepOrangeAccent, imageUrl: 'images/fried-rice.png', calories: '102 calories', isSelected: false),
    Food(name: 'White bread', backgroundColor: Colors.lightBlueAccent, imageUrl: 'images/bread.png', calories: '102 calories', isSelected: false),
    Food(name: 'Burger', backgroundColor: Colors.blue, imageUrl: 'images/burger.png', calories: '102 calories', isSelected: false),
  ];

  Offset offsets = const Offset(0.0, 0.0);
  bool visible = false;

  @override
  void initState() {
    // overlay Animation
    overlayAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500)
    );

    secondaryOverlayAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500)
    );

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1100),
        vsync: this
    );
    animationController.forward(from: 0);

    animations = foodListClass.map((animation){
      int index = foodListClass.indexOf(animation);
      double start = index * 0.1;
      return Tween<double>(begin: 600.0, end: 0.0).animate(
          CurvedAnimation(
              parent: animationController,
              curve: Interval(start, 1, curve: Curves.decelerate)));
    }).toList();

    super.initState();
  }

  // @override
  // void dispose() {
  //   animationController.dispose();
  //   super.dispose();
  // }

  late OverlayEntry entry;

  Future<void> overlayAnimationEnd() async{
    entry.remove();
  }

   showSecondaryOverlay(Offset woffset) {
    secondaryOverlayAnimationController.forward(from: 0);
    setState(() {
      offsets = woffset;
      visible = true;
      Future.delayed(const Duration(milliseconds: 1000),
          (){
            visible = false;
          }
      );

    });
  }

  Future<void> overlayAnimationStart(Offset offset) async {
       entry = OverlayEntry(
           builder: (context) {
             return AnimatedBuilder(
               animation: overlayAnimationController,
               builder: (context, child) =>
               Positioned(
                   left: 20,
                   top: offset.dy + (800 - offset.dy) * ( overlayAnimationController.value),
                   child:  GetBuilder<FoodController>(
                     builder: (_) => OverlayAnimation(onTap: ()
                     {
                       controller.changeOverlay();
                       entry.remove();
                       Navigator.push(context, MaterialPageRoute(builder: (_) => const ScheduleScreen()));
                     }
                     )
                   )
               ),
               child: GetBuilder<FoodController>(
                 builder: (_) => OverlayAnimation(onTap: ()
                   {
                     // entry.remove();
                     controller.changeOverlay();
                     Navigator.push(context, MaterialPageRoute(builder: (_) => const ScheduleScreen()));

                   }
                 )
               ),
             );
           }
       );

       Overlay.of(context)!.insert(entry);
       await overlayAnimationController.forward(from: 0);

    // entry.remove();
  }

  // IconButton(
  // onPressed: (){
  // entry.remove();
  // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  // },
  // icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
  // ),

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: GetBuilder<FoodController>(
          builder: (_) => IconButton(
            onPressed: (){
              controller.changeOverlay();
              if(controller.showOverlay == true){
                entry.remove();
              }
              else{
                controller.changeOverlay();
              }
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Text('Add to plate', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),)
      ),
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
          ),
          SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: foodListClass.length,
                  itemBuilder: (context, index) {
                  var food = foodListClass[index];
                  return AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return Transform(
                          transform: Matrix4.identity()
                            ..translate(animations[index].value, 0.0, 0.0),
                          child: child,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          height: size.height * .1,
                          width: size.width -40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.3),
                                  offset: const Offset(2.0, 2.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 1.0
                              )
                            ],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: FoodBox(
                            foodBGColors: food.backgroundColor,
                            name: food.name,
                            calories: food.calories,
                            imageUrl: food.imageUrl,
                            isSelected: food.isSelected,
                            onTap: (o) { overlayAnimationStart(o); },
                            secondary: (o) {showSecondaryOverlay(o);}
                            ),
                        ),
                      )
                  );
                  }
              ),
            ),
          ),
          Positioned(
            left: -40,
              bottom: -48,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 45, bottom: 40),
                  child: Icon(Icons.arrow_back_ios, size: 22, color: Colors.white,),
                ),
              )
          ),
      Visibility(
        visible: visible,
        child: AnimatedBuilder(
          animation: secondaryOverlayAnimationController,
          builder: (context, child) =>
              Positioned(
                  left: 40,
                  top: offsets.dy + (690 - offsets.dy) * (secondaryOverlayAnimationController.value),
                  child: SecondaryOverlay()
              ),
          child: SecondaryOverlay(),
        ),
      )
         ],
      ),
    );
  }

  List<Widget> foodList(Size size){
    return foodListClass.map((food){
      int index = foodListClass.indexOf(food);
      return AnimatedBuilder(
        animation: animationController,
          builder: (context, child) {
            return Transform(
                transform: Matrix4.identity()
                    ..translate(animations[index].value, 0.0, 0.0),
              child: child,
            );
          },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            height: size.height * .1,
            width: size.width -40,
            decoration: BoxDecoration(
              color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.3),
                      offset: const Offset(2.0, 2.0),
                      blurRadius: 0.0,
                      spreadRadius: 1.0
                  )
                ],
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text('ll'),
          ),
        )
      );
    }).toList();
  }
}

class Food {
  late String name;
  late Color backgroundColor;
  late String imageUrl;
  late String calories;
  late bool isSelected;

  Food({required this.name, required this.backgroundColor, required this.imageUrl, required this.calories, required this.isSelected});
}
