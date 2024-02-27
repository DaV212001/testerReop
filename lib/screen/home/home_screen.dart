import 'package:flutter/material.dart';

import '../../layout/home/category_section.dart';
import '../../layout/home/header_sample.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: ListView (
              children: const [
                HeaderSample(),
                Divider(),
                CategorySection()
              ],
            ),
          )
      ),
    );
  }
}