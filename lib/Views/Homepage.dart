import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttergalleryimage/Views/FlowersGallery.dart';
import 'package:get/get.dart';
import '../Controllers/HomepageController.dart';
import '../Controllers/FlowersGallerController.dart';

class Homepage extends StatelessWidget {
  // Instantiate the FlowerController using Get.put()
  final HomepageController controller = Get.put(HomepageController());
  final ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / 200).floor(); // Adjust 200 as per the desired item width

    return WillPopScope(
      onWillPop: () async {
        controller.showCustomDialog(context,
            "Exit App?",
            "Do you want to exit Application",
            "No", () {Navigator.of(context).pop();},
            "Yes", () {SystemNavigator.pop();});
        return false;
        },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title:     const Text("Gallery",style: TextStyle(color: Color(0xff3d0dad)),),
          leading: IconButton(
            onPressed: () {
              controller.showCustomDialog(context,
                  "Exit App?",
                  "Do you want to exit Application",
                  "No", () {Navigator.of(context).pop();},
                  "Yes", () {SystemNavigator.pop();});
            },
            icon: const Icon(Icons.arrow_back_ios, color:  Color(0xff3d0dad),),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
                () => GridView.builder(
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount, // Dynamically calculated columns
                crossAxisSpacing: 10.0, // space between items horizontally
                mainAxisSpacing: 10.0,  // space between items vertically
                childAspectRatio: 3 / 4, // Aspect ratio for container size
              ),
              itemCount: controller.flowers.length, // Access the flowers list
              itemBuilder: (context, index) {
                final flower = controller.flowers[index];
                return GestureDetector(
                    onTap: () {
                      // Map for heading and flowerType based on name
                      Map<String, String> nameMapping = {
                        "Flowers": "Flowers",
                        "Rivers": "Rivers",
                        "Mountains": "Mountains",
                        "Food": "Food",
                        "Birds": "Birds",
                        "City": "City",
                        "Cars": "Cars",
                        "Motivators": "Motivators",
                        "Arts": "Arts",
                        "Love": "Love",
                        "Joy": "Joy",
                        "Money": "Money",
                        "Fashion": "Fashion",
                        "World": "World"
                      };

                      String? selectedName = controller.flowers[index]['name'];
                      // Default to "Mountains" if name is not in the map
                      String heading = nameMapping[selectedName] ?? "Mountains";

                      imageController.AppBarHeading.value = heading;
                      imageController.flowerType.value = heading;

                      Get.to(() => const YellowFlowers());
                    },

                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              flower['image']!, // Display flower image
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          flower['name']!, // Display flower name
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
