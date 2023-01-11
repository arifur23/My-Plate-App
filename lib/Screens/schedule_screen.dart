import 'package:flutter/material.dart';
import 'package:my_plate_app/Screens/home_screen.dart';
import 'package:my_plate_app/Widgets/schedule_box.dart';

import 'add_to_plate_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with TickerProviderStateMixin {

 late AnimationController fabAnimation;

 late AnimationController animationController;
 late List<Animation> animations;

 List<Food> foodList = [
   Food(name: 'Pizza', backgroundColor: Colors.blue, imageUrl: 'images/pizza.png', calories: '102 calories', isSelected: false),
   Food(name: 'Bananas', backgroundColor: Colors.lightBlueAccent, imageUrl: 'images/banana.png', calories: '102 calories', isSelected: false),
 ];

 @override
  void initState() {
    fabAnimation = AnimationController(
      duration: const Duration(milliseconds: 500),
        vsync: this
    );
    fabAnimation.forward(from: 0);

    animationController = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this
    );
    animationController.forward(from: 0);

    animations = foodList.map((animation){
      int index = foodList.indexOf(animation);
      double start = index * 0.1;
      return Tween<double>(begin: 600.0, end: 0.0).animate(
          CurvedAnimation(
              parent: animationController,
              curve: Interval(start, 1, curve: Curves.decelerate)));
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: false,
        title: Text('Schedule',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(.8)),),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children:[
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
                itemCount: foodList.length,
                  itemBuilder: (context, index)
                  {
                  var food = foodList[index];
                  return AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) =>
                          Transform(
                              transform: Matrix4.identity()
                                  ..translate(0.0, animations[index].value, 0.0),
                            child: child,
                          ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: ScheduleBox(
                        name: food.name,
                        calories: food.calories,
                        backgroundColor: food.backgroundColor,
                        imageUrl: food.imageUrl,),
                    ),
                  );
                  }
              )
              ),
            ),
          Positioned(
            right: 20,
              bottom: 30,
              child: ScaleTransition(
                scale: fabAnimation,
                child: Container(
                  height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black,

                    ),
                    child: Center(
                        child: IconButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                          },
                          icon: const Icon(Icons.check, color: Colors.white, size: 25),
                        )
                    )
                ),
              )
          )
        ]
      ),
    );
  }
}
