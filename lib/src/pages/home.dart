import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/src/components/custom_appbar.dart';
import 'package:youtube_clone/src/components/video_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: CustomAppBar(),
            // 밑으로 스크롤할땐 app바 사라졌다가 다시 위로 스크롤하면 app바 나타남
            floating: true,
            snap: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: VideoWidget(),
                    onTap: () {
                      //page route
                      Get.toNamed("/detail/239587");
                    },
                  ),
                );
              },
              childCount: 10,
            ),
          )
        ],
      ),
    );
    ;
  }
}
