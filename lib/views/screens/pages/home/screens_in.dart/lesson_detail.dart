import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:practice_home/models/lesson.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonDetail extends StatefulWidget {
  const LessonDetail({super.key});

  @override
  State<LessonDetail> createState() => _LessonDetailState();
}

class _LessonDetailState extends State<LessonDetail> {
  late Lesson lesson;
  late YoutubePlayerController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    lesson = ModalRoute.of(context)!.settings.arguments as Lesson;
    final videoID = YoutubePlayer.convertUrlToId(lesson.videoUrl);

    if (videoID != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoID,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    } else {
      print('Invalid video URL');
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void listener() {
    if (_controller.value.isReady && !_controller.value.hasError) {
      print('Player is ready and video is playing');
    } else if (_controller.value.hasError) {
      print('Error playing video: ${_controller.value.errorCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lesson"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Video:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(10),
            if (_controller.initialVideoId.isNotEmpty)
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: false,
                progressIndicatorColor: Colors.amber,
                progressColors: const ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onReady: () {
                  _controller.addListener(listener);
                },
              )
            else
              const Text(
                'Invalid video URL',
                style: TextStyle(color: Colors.red),
              ),
            const Gap(20),
            Text(
              lesson.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              lesson.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Gap(20),
            const Text(
              "Test",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.all(10),
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, 'quiz_game',
                      arguments: lesson.quizzes);
                },
                title: const Text("Tests"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
