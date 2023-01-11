import 'package:flutter/material.dart';

class TimeBox extends StatelessWidget {

  final List<String> list;
  final IconData icon;
  final String calories;
  final String title;

  const TimeBox({super.key, required this.list, required this.icon, required this.calories, required this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * .27,
        width: size.width * .43,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  offset: const Offset(5.0, 7.0),
                  blurRadius: 0.0,
                spreadRadius: 1.0
              )
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Center(
                  child: Row(
                    children: [
                      Icon(icon),
                      const SizedBox(width: 10,),
                      Text(title, style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 20, color: Colors.black),)

                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: list.map((imageUrl) => Container(
                  height: 30,
                    width: 30,
                    child: Image.asset('images/$imageUrl', fit: BoxFit.cover,)
                )
                ).toList(),
              ),
              Text('$calories calories', style: TextStyle(color: Colors.black.withOpacity(.3), fontSize: 16, fontWeight: FontWeight.w600),)
            ],
          ),
        )
    );
  }
}