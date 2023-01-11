import 'package:flutter/material.dart';

import '../Screens/add_to_plate_screen.dart';

class MyPlateIconBox extends StatelessWidget {
  const MyPlateIconBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('My Plate', style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: const BoxDecoration(),
              child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(
                          onPressed: () {

                          },
                          icon: const Icon(
                            Icons.notifications, size: 40, color: Colors.grey,)
                      ),
                    ),
                    Positioned(
                        top: 13,
                        right: 13,
                        child: Container(
                          height: 13,
                          width: 13,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.white, width: 2.5)
                          ),
                        )
                    )
                  ]
              ),
            ),
            const SizedBox(width: 30,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddToPlateScreen()));
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: const Icon(Icons.add, size: 25, color: Colors.white,),
              ),
            )
          ],
        )
      ],
    );
  }
}