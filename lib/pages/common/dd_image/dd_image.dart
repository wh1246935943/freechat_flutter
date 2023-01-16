import 'package:flutter/material.dart';

class DDImage extends StatelessWidget  {

  final String url;
  
  final double height;
  
  final double width;

  final BoxFit fit;

  const DDImage({
    super.key, 
    required this.url,
    this.height = 40,
    this.width = 40,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {

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
  
}