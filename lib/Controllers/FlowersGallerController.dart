import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Models/ImageModel.dart';

class ImageController extends GetxController {
  var images = <HomeImageData>[].obs;  // List of images (Observable)
  var isLoading = false.obs;       // Loading state (Observable)
  int currentPage = 1;             // To manage pagination

  var flowerType = "".obs;
  var AppBarHeading = "".obs;

  // Method to fetch images from API
  Future<void> fetchImages({bool isLoadMore = false}) async {
    if (isLoadMore) {
      currentPage++;  // Increment page for loading more images
    } else {
      images.clear();  // Clear images if it's not a load more action
      currentPage = 1;
    }

    isLoading(true);  // Set loading to true

    final response = await http.get(Uri.parse('https://pixabay.com/api/?key=46284745-c507d6159d6998a8770d2d4ae&q=${flowerType.value}&image_type=photo&page=$currentPage'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<HomeImageData> fetchedImages = (data['hits'] as List)
          .map((image) => HomeImageData.fromJson(image))
          .toList();

      // Remove duplicate images based on URL
      List<HomeImageData> uniqueImages = fetchedImages.where((newImage) {
        return !images.any((existingImage) => existingImage.url == newImage.url);
      }).toList();

      // Add only unique images to the list
      images.addAll(uniqueImages);
    } else {
      throw Exception('Failed to load images');
    }

    isLoading(false);  // Set loading to false
  }

  // Method to handle pull-to-refresh
  Future<void> refreshImages() async {
    await fetchImages(isLoadMore: false);
  }

  // Method to handle load more images
  Future<void> loadMoreImages() async {
    await fetchImages(isLoadMore: true);
  }
}
