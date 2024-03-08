import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../model/lesson_description.dart';

class PdfScreen extends StatelessWidget {
  LessonDescription? lesson;
  PdfScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: lesson?.books?.length,
      itemBuilder: (context, index1) {
        if(lesson!.books!.isEmpty){
          return const Center(child: Text("No books Available currently"));
        }else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.4),
                  )
                ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height*0.1,
                          right: MediaQuery.of(context).size.height*0.1,
                          top: MediaQuery.of(context).size.height*0.05
                      ),
                      child: Icon(
                        FontAwesomeIcons.book,
                      ),
                    ),
                  ),
                  Text(lesson!.books![index1].title,
                      style: theme.textTheme.labelLarge),
                ],
              ),
            ),
          );
        }
      }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: MediaQuery.of(context).size.height*0.15
      ),
    );
  }
}
