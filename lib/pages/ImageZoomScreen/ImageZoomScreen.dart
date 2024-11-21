import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageZoomScreen extends StatelessWidget {
  final String imageUrl;

  ImageZoomScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(); // Close the screen when tapped outside the image
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PhotoView(

          imageProvider: CachedNetworkImageProvider(imageUrl),
          backgroundDecoration: BoxDecoration(
            color: Colors.transparent,

          ),
          minScale: PhotoViewComputedScale.contained, // Prevents zooming out beyond the original size
          maxScale: PhotoViewComputedScale.covered * 2.0,
        ),
      ),
    );
  }
}