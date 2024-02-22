import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mss_e_learning/generated/assets.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  const CachedImage({super.key, required this.url, required this.fit});

  @override
  Widget build(BuildContext context) {
    return FastCachedImage(//works with webp
      url: url,
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 250),
      errorBuilder: (context, exception, stacktrace) {
        return Container(
          color: Colors.transparent,
          child: Image.asset(Assets.socialTelegram),
        );
      },
      loadingBuilder: (context, progress) {
        return Container(
          color: Colors.transparent,
        );
      },
    );
  }
}
