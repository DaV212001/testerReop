import 'package:flutter/material.dart';

import '../../model/lesson_description.dart';

class PdfScreen extends StatelessWidget {
  LessonDescription? lesson;
  PdfScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: lesson?.books.length,
      itemBuilder: (context, index1) {
        if(lesson!.books.isEmpty){
          return const Center(child: Text("No books Available currently"));
        }else {
          return ExpansionTile(
            leading: ClipOval(
              child: Container(
                width: 50,
                height: 50,
                color: Colors.red,
              ),
            ),
            title: Text(lesson!.books[index1].title,
                style: theme.textTheme.labelLarge),
            children: [
              Text(lesson!.books[index1].url ?? ""),
              Text(lesson!.books[index1].file ?? "") //file
            ],
          );
        }
      },
    );
  }
}
