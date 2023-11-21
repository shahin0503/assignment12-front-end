import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const CircularImage({
    super.key,
    required this.imageUrl,
    this.size = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: imageUrl != null
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              fit: BoxFit.cover,
              width: 50.0 + size,
              height: 50.0 + size,
            )
          : const Icon(
              Icons.person,
              size: 50,
            ),
    );
  }
}
