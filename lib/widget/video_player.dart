import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  final String link;

  const YoutubeVideoPlayer({Key? key, required this.link}) : super(key: key);

  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(
        widget.link,
      ),
      podPlayerConfig: const PodPlayerConfig(
          autoPlay: false, isLooping: false, videoQualityPriority: [720, 360]),
    )..initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
        child: PodVideoPlayer(
          podProgressBarConfig: PodProgressBarConfig(
              playingBarColor: theme.colorScheme.primary,
              circleHandlerColor: theme.colorScheme.primary,
              bufferedBarColor: theme.colorScheme.primary),
          controller: controller,
          backgroundColor: theme.colorScheme.tertiary
        )
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
