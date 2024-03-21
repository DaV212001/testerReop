import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mss_e_learning/generated/assets.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final bool? fromCarousel;
  const CachedImage({super.key, required this.url, required this.fit, this.fromCarousel});

  @override
  Widget build(BuildContext context) {
    if(url.endsWith('.svg')){
      return SvgPicture.network(url);
    } else {
      return FastCachedImage( //works with webp
        url: url,
        fit: fit,
        fadeInDuration: const Duration(seconds: 1),
        errorBuilder: (context, exception, stacktrace) {
          return Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme
                  .of(context)
                  .primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Image.asset(Assets.imagesPlaceholderLogo),
          );
        },
        loadingBuilder: (context, progress) {
          if(fromCarousel != null && fromCarousel!){
            return Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ));
          }
          return Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(15)),

            ),
            child: Image.asset(Assets.imagesPlaceholderLogo),
          );
        },
      );
    }
  }
}
