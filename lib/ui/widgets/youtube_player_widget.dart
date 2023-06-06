import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerWidget extends StatefulWidget {
  final String videoUrl;
  const YoutubePlayerWidget({required this.videoUrl, super.key});

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgeteState();
}

class _YoutubePlayerWidgeteState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();

    String? videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? 'iLnmTe5Q2Qw',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
    );
  }
}
