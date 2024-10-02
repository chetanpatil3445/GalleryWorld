import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../Controllers/FlowersGallerController.dart';
import 'ImageDetailPage.dart';

class YellowFlowers extends StatefulWidget {
  const YellowFlowers({super.key});

  @override
  State<YellowFlowers> createState() => _YellowFlowersState();
}

class _YellowFlowersState extends State<YellowFlowers> {
  final ImageController imageController = Get.put(ImageController());

  @override
  void initState() {
    super.initState();
    imageController.fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / 200).floor(); // Adjust 200 as per the desired item width
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          imageController.AppBarHeading.value,
          style: const TextStyle(color: Color(0xff3d0dad)),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0xff3d0dad)),
        ),
      ),
      body: Obx(() {
        if (imageController.isLoading.value && imageController.images.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.pink),
          );
        }

        return RefreshIndicator(
          onRefresh: imageController.refreshImages, // For pull-to-refresh
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                  !imageController.isLoading.value) {
                // Load more images when scrolled to the bottom
                imageController.loadMoreImages();
              }
              return true;
            },
            child: Stack(
              children: [
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount, // Adjust columns based on screen width
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                    childAspectRatio: 1, // Ensure square aspect ratio
                  ),
                  itemCount: imageController.images.length,
                  itemBuilder: (context, index) {
                    final image = imageController.images[index];

                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ImageDetailPage(
                          imageUrl: image.url,
                          likes: image.likes,
                          views: image.views,
                          tags: image.tags,
                        ));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch, // Fix overflow issue by stretching images to fill space
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: image.url,
                              placeholder: (context, url) => buildPlaceholderList2(),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/noIMG.png",
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: MediaQuery.of(context).size.height * 0.2,
                                fit: BoxFit.fill,
                              ),
                              fit: BoxFit.cover, // Ensure images fit well in grid
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute space evenly
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.thumb_up, size: 16), // Icon for likes
                                    SizedBox(width: 4), // Space between icon and text
                                    Text('${image.likes}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.visibility, size: 16), // Icon for views
                                    SizedBox(width: 4), // Space between icon and text
                                    Text('${image.views}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // Show loader at the bottom when more images are loading
                if (imageController.isLoading.value && imageController.images.isNotEmpty)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget buildPlaceholderList2() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!, // Placeholder color
          highlightColor: Colors.grey[100]!, // Highlight color
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300], // Placeholder color
              borderRadius: BorderRadius.circular(8),
            ),
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
        ),
      ),
    );
  }
}
