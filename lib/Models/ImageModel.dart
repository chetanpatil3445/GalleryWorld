class HomeImageData {
  final String url;
  final int likes;
  final int views;
  final String tags;

  HomeImageData({required this.url, required this.likes, required this.views , required this.tags});

  factory HomeImageData.fromJson(Map<String, dynamic> json) {
    return HomeImageData(
      url: json['largeImageURL'],
      likes: json['likes'],
      views: json['views'],
      tags: json['tags'],
    );
  }
}
