import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

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
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: lesson?.videos?.length,
      itemBuilder: (context, index1) {
        if(lesson!.videos!.isEmpty){
          return const Center(child: Text("No Videos Available currently"));
        }else{
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: YoutubeVideoPlayer(
                      link: lesson!.videos![index1].url.toString(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Text(lesson!.videos![index1].title,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).secondaryText
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      mainAxisExtent: height*0.35
      ),
    );
  }
}
