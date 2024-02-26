import 'package:flutter/material.dart';

import '../../model/lesson_description.dart';
import '../../widget/video_player.dart';

class VideoScreen extends StatelessWidget {
  LessonDescription? lesson;
  VideoScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: lesson?.videos.length,
      itemBuilder: (context, index1) {
        if(lesson!.videos.isEmpty){
          return const Center(child: Text("No Videos Available currently"));
        }else{
          return ExpansionTile(
            leading: ClipOval(
              child: Container(
                width: 50,
                height: 50,
                color: Colors.red,
              ),
            ),
            title: Text(lesson!.videos[index1].title,
                style: theme.textTheme.labelLarge),
            children: [
              SizedBox(
                width: width,
                height: height * 0.3,
                child: YoutubeVideoPlayer(
                  link: lesson!.videos[index1].url.toString(),
                ),
              )
            ],
          );
        }
      },
    );
  }
}
