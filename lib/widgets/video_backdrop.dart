import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoBackdrop extends StatefulWidget {
  final String videoAsset;
  final String firstFrameAsset;

  const VideoBackdrop({
    Key? key,
    required this.videoAsset,
    required this.firstFrameAsset,
  }) : super(key: key);

  @override
  _VideoBackdropState createState() => _VideoBackdropState();
}

class _VideoBackdropState extends State<VideoBackdrop> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoAsset)
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: _controller.value.isInitialized
          ? FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            )
          : Image.asset(
              widget.firstFrameAsset,
              fit: BoxFit.cover,
            ),
    );
  }
}
