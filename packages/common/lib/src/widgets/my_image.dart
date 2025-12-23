import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  const MyImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    required this.fit,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final memWidth = width != null ? (width! * devicePixelRatio) : null;
    final memHeight = height != null ? (height! * devicePixelRatio) : null;
    final diskWidth = width != null ? (width! * 2) : null;
    final diskHeight = height != null ? (height! * 2) : null;

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      fadeOutDuration: Duration.zero,
      fadeInDuration: Duration.zero,
      memCacheWidth: memWidth?.isFinite ?? false ? memWidth?.round() : null,
      memCacheHeight: memHeight?.isFinite ?? false ? memHeight?.round() : null,
      maxWidthDiskCache:
          diskWidth?.isFinite ?? false ? diskWidth?.round() : null,
      maxHeightDiskCache:
          diskHeight?.isFinite ?? false ? diskHeight?.round() : null,
      cacheKey: imageUrl,
      useOldImageOnUrlChange: true,
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        color: Colors.grey[80],
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: const Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      ),
    );
  }
}
