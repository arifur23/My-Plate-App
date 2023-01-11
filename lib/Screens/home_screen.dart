import 'package:flutter/material.dart';
import '../Widgets/bottom_week.dart';
import '../Widgets/my_plate_icon_box.dart';
import '../Widgets/time_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  List<String> week = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  late AnimationController plateBoxAnimationController;
  late Animation plateBoxAnimation;
  late AnimationController box1AnimationController;
  late AnimationController box2AnimationController;
  late AnimationController box3AnimationController;
  late AnimationController box4AnimationController;
  late AnimationController box5AnimationController;
  late Animation box1Animation;
  late Animation box2Animation;
  late Animation box3Animation;
  late Animation box4Animation;
  late Animation box5Animation;

  @override
  void initState() {
    super.initState();
    plateBoxAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    plateBoxAnimation = Tween<double>(begin: 800.0, end: 0.0).animate(
        CurvedAnimation(
            parent: plateBoxAnimationController,
            curve: const Interval(0, .6, curve: Curves.decelerate)));

    // box1 Animations
    box1AnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    box1Animation = Tween<double>(begin: 800.0, end: 0.0).animate(
        CurvedAnimation(
            parent: box1AnimationController,
            curve: const Interval(0, .6, curve: Curves.decelerate)));

    // box2 Animations
    box2AnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    box2Animation = Tween<double>(begin: 800.0, end: 0.0).animate(
        CurvedAnimation(
            parent: box2AnimationController,
            curve: const Interval(0, .6, curve: Curves.decelerate)));

    // box3 Animations
    box3AnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    box3Animation = Tween<double>(begin: 800.0, end: 0.0).animate(
        CurvedAnimation(
            parent: box3AnimationController,
            curve: const Interval(0, .6, curve: Curves.decelerate)));

    // box4 Animations
    box4AnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2100),
    );
    box4Animation = Tween<double>(begin: 800.0, end: 0.0).animate(
        CurvedAnimation(
            parent: box4AnimationController,
            curve: const Interval(0, .6, curve: Curves.decelerate)));

    // box5 Animations
    box5AnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2300),
    );
    box5Animation = Tween<double>(begin: 800.0, end: 0.0).animate(
        CurvedAnimation(
            parent: box5AnimationController,
            curve: const Interval(0, .6, curve: Curves.decelerate)));



    plateBoxAnimationController.forward();
    box1AnimationController.forward();
    box2AnimationController.forward();
    box3AnimationController.forward();
    box4AnimationController.forward();
    box5AnimationController.forward();
  }

  @override
  void dispose() {
    plateBoxAnimationController.dispose();
    box1AnimationController.dispose();
    box2AnimationController.dispose();
    box3AnimationController.dispose();
    box4AnimationController.dispose();
    box5AnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    child: Container(
                      height: size.height * .67,
                      width: size.width - 40,
                      decoration: const BoxDecoration(
                      ),
                      child: Column(
                        children: [
                          AnimatedBuilder(
                            animation: plateBoxAnimationController,
                            child: const MyPlateIconBox(),
                            builder: (context, child) =>
                                Transform(
                                  transform: Matrix4.identity()
                                    ..translate( 0.0, plateBoxAnimation.value, 0.0),
                                  child: child,
                                ),
                          ),
                          const SizedBox(height: 45,),
                          Row(
                            children: [
                              AnimatedBuilder(
                                animation: box1AnimationController,
                                child: const TimeBox(list: ['banana.png', 'bread.png', 'coffee.png'], calories: '460', title: 'Morning', icon: Icons.more_time_sharp,),
                                builder: (context, child) =>
                                    Transform(
                                      transform: Matrix4.identity()
                                        ..translate( 0.0, box1Animation.value, 0.0),
                                      child: child,
                                    ),
                              ),
                              const SizedBox(width: 5,),
                              AnimatedBuilder(
                                animation: box2AnimationController,
                                child:  const TimeBox(list: ['barbecue.png', 'pasta.png', 'chicken-leg.png'], calories: '162', title: 'Afternoon', icon: Icons.animation,),
                                builder: (context, child) =>
                                    Transform(
                                      transform: Matrix4.identity()
                                        ..translate( 10.0, box2Animation.value, 0.0),
                                      child: child,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              const SizedBox(height: 20,),
                              AnimatedBuilder(
                                animation: box3AnimationController,
                                child:  const TimeBox(list: ['tea.png', 'pizza.png',], calories: '130', title: 'Evening', icon: Icons.more_time_sharp,),
                                builder: (context, child) =>
                                    Transform(
                                      transform: Matrix4.identity()
                                        ..translate( 0.0, box3Animation.value, 0.0),
                                      child: child,
                                    ),
                              ),
                              const SizedBox(width: 5,),
                              AnimatedBuilder(
                                animation: box4AnimationController,
                                child:  const TimeBox(list: ['pizza.png', 'burger.png'], calories: '100', title: 'Night', icon: Icons.more_time_sharp,),
                                builder: (context, child) =>
                                    Transform(
                                      transform: Matrix4.identity()
                                        ..translate( 10.0, box4Animation.value, 0.0),
                                      child: child,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 65,),
                  AnimatedBuilder(
                      animation: box5AnimationController,
                      builder: (context, child) =>
                          Transform(
                              transform: Matrix4.identity()
                                  ..translate(0.0, box5Animation.value, 0.0),
                            child: child,
                          ),
                    child: Container(
                      height: size.height * .1,
                      width: size.width,
                      decoration: const BoxDecoration(
                      ),
                      child: Row(
                          children: [
                            BuildWeek(day: week[0], ontap: (){}, isSelected: false),
                            BuildWeek(day: week[1], ontap: (){}, isSelected: false),
                            BuildWeek(day: week[2], ontap: (){}, isSelected: false),
                            BuildWeek(day: week[3], ontap: (){}, isSelected: true),
                            BuildWeek(day: week[4], ontap: (){}, isSelected: false),
                            BuildWeek(day: week[5], ontap: (){}, isSelected: false),
                            BuildWeek(day: week[6], ontap: (){}, isSelected: false),
                          ]
                      ),
                    ),
                  )
                ]
            ),
          ),
        ],
      ),
    );
  }
}

class BuildWeek extends StatelessWidget {
  final String day;
  final VoidCallback ontap;
  final bool isSelected;

  const BuildWeek({super.key, required this.day, required this.ontap, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.9),
      child: GestureDetector(
        onTap: ontap,
        child: Column(
          children: [
            Text(day, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  border: Border.all(color: isSelected ? Colors.black : Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(50)
              ),
              child: Center(
                child: Container(
                  height: 4,
                  width: 4,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50)
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



