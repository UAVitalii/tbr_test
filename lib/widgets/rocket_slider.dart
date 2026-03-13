import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/rocket.dart';

class RocketSlider extends StatefulWidget {
  final List<Rocket> rockets;
  final int selectedIndex;
  final ValueChanged<int> onPageChanged;

  const RocketSlider({
    super.key,
    required this.rockets,
    required this.selectedIndex,
    required this.onPageChanged,
  });

  @override
  State<RocketSlider> createState() => _RocketSliderState();
}

class _RocketSliderState extends State<RocketSlider> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.78,
      initialPage: widget.selectedIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 194,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.rockets.length,
        onPageChanged: widget.onPageChanged,
        itemBuilder: (context, index) {
          final rocket = widget.rockets[index];
          final isSelected = index == widget.selectedIndex;
          final imageUrl = rocket.flickrImages.isNotEmpty
              ? rocket.flickrImages.first
              : '';

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: isSelected ? 0 : 24,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[800],
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[800],
                        child: const Center(
                          child: Icon(Icons.rocket_launch,
                              color: Colors.white54, size: 52),
                        ),
                      ),
                    )
                  : Container(
                      color: Colors.grey[800],
                      child: const Center(
                        child: Icon(Icons.rocket_launch,
                            color: Colors.white54, size: 52),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
