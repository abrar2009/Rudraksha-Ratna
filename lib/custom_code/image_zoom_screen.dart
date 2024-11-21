/*
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class imageZoomScreen extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex; // Starting index when an image is clicked

  imageZoomScreen({required this.imageUrls, this.initialIndex = 0});

  @override
  _imageZoomScreenState createState() => _imageZoomScreenState();
}

class _imageZoomScreenState extends State<imageZoomScreen> {
  late PageController _pageController;
  int _currentPage = 0; // Keep track of the current page
  bool _isZoomed = false; // Check if the image is zoomed in

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _currentPage = widget.initialIndex; // Set initial page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isZoomed ? Colors.transparent : Colors.transparent,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.imageUrls.length,
                    onPageChanged: (index) {
                      // Update the current page when the user scrolls
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _isZoomed = !_isZoomed; // Toggle zoom state
                          });
                        },
                        child: InteractiveViewer(
                          panEnabled: true,
                          minScale: 1.0,
                          maxScale: 4.0,
                          onInteractionStart: (_) {
                            setState(() {
                              _isZoomed = true; // Change background when zoomed
                            });
                          },
                          onInteractionEnd: (_) {
                            setState(() {
                              _isZoomed = false; // Restore background when zooming ends
                            });
                          },
                          child: CachedNetworkImage(
                            imageUrl: widget.imageUrls[index],
                            fit: BoxFit.contain,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Dots for pagination indicators
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.imageUrls.map((url) {
                    int index = widget.imageUrls.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? FlutterFlowTheme.of(context).primary
                            : Colors.grey,
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
              ],
            ),
            // Close button at the top right
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: FlutterFlowTheme.of(context).primary,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the zoom screen
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/


import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class imageZoomScreen extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  imageZoomScreen({required this.imageUrls, this.initialIndex = 0});

  @override
  _imageZoomScreenState createState() => _imageZoomScreenState();
}

class _imageZoomScreenState extends State<imageZoomScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  bool _isZoomed = false;
  TransformationController _transformationController = TransformationController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _currentPage = widget.initialIndex;
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _handleDoubleTap(Offset localPosition) {
    final scale = _transformationController.value.getMaxScaleOnAxis();

    // Check if already zoomed in, if yes then reset to default zoom level
    if (scale > 1.0) {
      _transformationController.value = Matrix4.identity();
      setState(() {
        _isZoomed = false;
      });
    } else {
      final position = localPosition;
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(2.0); // Zoom in by 2x
      setState(() {
        _isZoomed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isZoomed ? Colors.transparent : Colors.transparent,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.imageUrls.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onDoubleTapDown: (details) => _handleDoubleTap(details.localPosition),
                        onDoubleTap: () => _handleDoubleTap(Offset.zero), // Double-tap zoom
                        child: InteractiveViewer(
                          transformationController: _transformationController,
                          panEnabled: true,
                          minScale: 1.0,
                          maxScale: 4.0,
                          onInteractionStart: (_) {
                            setState(() {
                              _isZoomed = true;
                            });
                          },
                          onInteractionEnd: (_) {
                            setState(() {
                              // If scale goes back to normal, treat it as not zoomed
                              if (_transformationController.value.getMaxScaleOnAxis() <= 1.0) {
                                _isZoomed = false;
                              }
                            });
                          },
                          child: CachedNetworkImage(
                            imageUrl: widget.imageUrls[index],
                            fit: BoxFit.contain,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.imageUrls.map((url) {
                    int index = widget.imageUrls.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? FlutterFlowTheme.of(context).primary
                            : Colors.grey,
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
              ],
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: FlutterFlowTheme.of(context).primary,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
