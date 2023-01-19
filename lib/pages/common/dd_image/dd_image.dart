import 'package:flutter/material.dart';

class DDImage extends StatelessWidget  {

  final String url;
  
  final double height;
  
  final double width;

  final BoxFit fit;

  final bool isNet;

  const DDImage({
    super.key, 
    required this.url,
    this.height = 40,
    this.width = 40,
    this.fit = BoxFit.cover,
    this.isNet = true
  });

  @override
  Widget build(BuildContext context) {

    if (isNet) {
      return Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => Image.asset(
          'lib/assets/default_avatar.jpg',
          height: height,
          width: width
        )
      );
    }
    return Image.asset(
      url,
      height: height,
      width: width
    );
  }
  
}