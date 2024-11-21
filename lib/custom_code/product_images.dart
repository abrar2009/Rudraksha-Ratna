import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rudraksha_cart/components/shimmer_widget.dart';
import 'package:rudraksha_cart/flutter_flow/flutter_flow_theme.dart';
import 'image_zoom_screen.dart';

class ProductImagesWidget extends StatefulWidget {
  final List<String> imageUrls;

  ProductImagesWidget({required this.imageUrls});

  @override
  _ProductImagesWidgetState createState() => _ProductImagesWidgetState();
}

class _ProductImagesWidgetState extends State<ProductImagesWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasMultipleImages = widget.imageUrls.length > 1; // Check if there are multiple images

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 288,
          child: CarouselSlider.builder(
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index, realIndex) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => imageZoomScreen(
                        imageUrls: widget.imageUrls,
                        initialIndex: index, // Pass the index of the clicked image
                      ),
                    ),
                  );
                },
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrls[index],
                  fadeInDuration: Duration(milliseconds: 100),
                  fadeOutDuration: Duration(milliseconds: 100),
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(child: ShimmerWidget()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              );
            },
            options: CarouselOptions(
              viewportFraction: 1.0,
              height: 288,
              autoPlay: hasMultipleImages,
              autoPlayInterval: Duration(seconds: 3),
              enableInfiniteScroll: hasMultipleImages,
              scrollPhysics: hasMultipleImages
                  ? AlwaysScrollableScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ),
        if (hasMultipleImages)
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imageUrls.map((url) {
                int index = widget.imageUrls.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? FlutterFlowTheme.of(context).primary
                        : Colors.grey,
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
