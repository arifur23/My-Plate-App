import 'package:flutter/material.dart';

class ScheduleBox extends StatefulWidget {
  final String name;
  final String calories;
  final String imageUrl;
  final Color backgroundColor;

  const ScheduleBox({super.key, required this.name, required this.calories, required this.backgroundColor, required this.imageUrl});

  @override
  State<ScheduleBox> createState() => _ScheduleBoxState();
}

enum Time{
  today,
  everyday,
  dayInterval
}

class _ScheduleBoxState extends State<ScheduleBox> {


  bool m = false;
  bool a = false;
  bool e = false;
  bool n = false;

  Time time = Time.today;
  int itemNumber = 1;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .18,
      width: size.width - 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.6),
            offset: const Offset(1.0, 1.0),
            blurRadius: 1.0,
            spreadRadius: 1.0
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                itemNumber++;
                              });
                            },
                            child: Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: widget.backgroundColor
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: -5,
                                      right: -5,
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(.7),
                                          border: Border.all(color: Colors.black.withOpacity(.5),width: 1)
                                        ),
                                        child: Center(
                                          child: itemNumber < 2? Icon(Icons.add, color: Colors.black.withOpacity(.5),) : Text(itemNumber.toString(), style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                                        ),
                                      )
                                  )
                                  ,
                                  Center(
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                        child: Image.asset(widget.imageUrl, fit: BoxFit.cover,),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ),
                          const SizedBox(width: 15,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                              Text(widget.calories, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black.withOpacity(.4)))
                            ],
                          )
                        ],
                      ),
                      const SizedBox(width: 30,),
                      Container(
                        width: size.width * .4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TimeWidget(day: 'M', isSelected: m, onTap: (){
                              setState(() {
                                m = !m;
                              });
                            }),
                            TimeWidget(day: 'A', isSelected: a, onTap: (){setState(() {
                              a = !a;
                            });}),
                            TimeWidget(day: 'E', isSelected: e, onTap: (){setState(() {
                              e = !e;
                            });}),
                            TimeWidget(day: 'N', isSelected: n, onTap: (){setState(() {
                              n = !n;
                            });
                            }),

                            Container(
                              height: 28,
                              width: 28,
                              child: const Center(
                                child: Icon(Icons.keyboard_arrow_down, size: 17,),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
            Expanded(child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DayWidget(size: size, day: 'Today', isSelected: time == Time.today ? true : false, onTap: () {
                    setState(() {
                      time = Time.today;
                    });
                  },),
                  DayWidget(size: size, day: 'Everyday', isSelected: time == Time.everyday ? true : false, onTap: () {
                    setState(() {
                      time = Time.everyday;
                    });
                  },),
                  DayWidget(size: size, day: 'Interval', isSelected: time == Time.dayInterval ? true : false, onTap: () {
                    setState(() {
                      time = Time.dayInterval;
                    });
                  },),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class DayWidget extends StatelessWidget {
  final String day;
  final Size size;
  final bool isSelected;
  final VoidCallback onTap;

  const DayWidget({super.key, required this.day, required this.size, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        width: size.width * .25,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Center(
          child: Text(day, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : Colors.black),),
        ),
      ),
    );
  }
}

class TimeWidget extends StatelessWidget {
  final String day;
  final bool isSelected;
  final VoidCallback onTap;

   const TimeWidget({super.key, required this.day, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue: Colors.white,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.black.withOpacity(.5), width: 2)
        ),
        child: Center(
          child: Text(day, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: isSelected ? Colors.white : Colors.black.withOpacity(.7)),),
        ),
      ),
    );
  }
}
