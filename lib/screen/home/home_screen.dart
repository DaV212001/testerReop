import 'package:flutter/material.dart';

import '../../layout/home/header_sample.dart';
import '../../layout/home/post_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column (
          children: [
            HeaderSample(),
            Divider(),
            PostList()
          ],
        )
      ),
    );
  }
}
