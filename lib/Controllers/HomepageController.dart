import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomepageController extends GetxController {
  // List of flower categories with images and text
  final flowers = [
    {"name": "Rivers", "image": "assets/river.jpg"},
    {"name": "Mountains", "image": "assets/Mountain.jpg"},
    {"name": "Flowers", "image": "assets/BlueFlowers.jpg"},
    {"name": "Food", "image": "assets/Food.jpg"},
    {"name": "Birds", "image": "assets/Birds.jpg"},
    {"name": "City", "image": "assets/City.jpg"},
    {"name": "Cars", "image": "assets/Cars.jpg"},
    {"name": "Motivators", "image": "assets/Motivations.jpg"},
    {"name": "Arts", "image": "assets/Arts.jpg"},
    {"name": "Love", "image": "assets/Love.jpg"},
    {"name": "Joy", "image": "assets/Joy.jpg"},
    {"name": "Money", "image": "assets/Money.jpg"},
    {"name": "Fashion", "image": "assets/Fashion.jpg"},
    {"name": "World", "image": "assets/World.jpg"},

  ].obs; // .obs makes it observable in GetX

  void showCustomDialog(
      BuildContext context,
      String title,
      String content,
      String yesButtonText,
      VoidCallback onYesPressed,
      String noButtonText,
      VoidCallback onNoPressed
      ) {
    Get.dialog(
      AlertDialog(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            content,
            style: TextStyle(fontSize: 16),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: onNoPressed,
                child: Text(
                  noButtonText,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: onYesPressed,
                child: Text(
                  yesButtonText,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        backgroundColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }
}
