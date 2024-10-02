import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageDetailPage extends StatefulWidget {
  final String imageUrl;
  final int likes;
  final int views;
  final String tags;

  const ImageDetailPage({
    Key? key,
    required this.imageUrl,
    required this.likes,
    required this.views,
    required this.tags,
  }) : super(key: key);

  @override
  _ImageDetailPageState createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  late TransformationController _transformationController;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _resetZoom() {
    setState(() {
      _transformationController.value = Matrix4.identity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Flower Detail Page", style: TextStyle(color: Color(0xff3d0dad))),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0xff3d0dad)),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;

          return Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onScaleEnd: (details) {
                    _resetZoom();
                  },
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    panEnabled: false,
                    boundaryMargin: EdgeInsets.all(80),
                    minScale: 0.5,
                    maxScale: 6.0,
                    onInteractionEnd: (details) {
                      _resetZoom();
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width * (width > 600 ? 0.4 : 0.8), // 40% for larger screens, 80% for smaller
                              height: height * (width > 600 ? 0.4 : 0.4), // Set height to be responsive
                              child: CachedNetworkImage(
                                imageUrl: widget.imageUrl,
                                placeholder: (context, url) => buildPlaceholderList2(),
                                errorWidget: (context, url, error) => Image.asset(
                                  "assets/noIMG.png",
                                  width: width * 0.2,
                                  height: height * 0.2,
                                  fit: BoxFit.fill,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.tags, style: TextStyle(color: Color(0xff3d0dad))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.thumb_up),
                        SizedBox(width: 8),
                        Text('Likes: ${widget.likes}'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.visibility),
                        SizedBox(width: 8),
                        Text('Views: ${widget.views}'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildPlaceholderList2() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
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
