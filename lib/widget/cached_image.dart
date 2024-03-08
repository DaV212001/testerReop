import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
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
      fadeInDuration: const Duration(seconds: 1),
      errorBuilder: (context, exception, stacktrace) {
        return Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child:Image.asset(Assets.imagesPlaceholderLogo),
        );
      },
      loadingBuilder: (context, progress) {
        return Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(15)),

            ),
          child:Image.asset(Assets.imagesPlaceholderLogo),
        );
      },
    );
  }
}
