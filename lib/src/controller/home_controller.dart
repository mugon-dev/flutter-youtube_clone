//video list 불러오기
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/src/models/youtube_video_result.dart';
import 'package:youtube_clone/src/respository/youtube_repository.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  Rx<YoutubeVideoResult> youtubeResult = YoutubeVideoResult(items: []).obs;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    // TODO: implement onInit
    _videoLoad();
    _event();
    super.onInit();
  }

  void _event() {
    scrollController.addListener(() {
      // 스크롤 할때 하단 픽셀 위치
      // print(scrollController.position.pixels);
      // 가장 하단 위치
      // print(scrollController.position.maxScrollExtent);
      // 스크롤이 마지막에 도착하면
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          youtubeResult.value.nextPagetoken != "") {
        _videoLoad();
      }
    });
  }

  void _videoLoad() async {
    YoutubeVideoResult? youtubeVideoResult = await YoutubeRepository.to
        .loadVideos(youtubeResult.value.nextPagetoken ?? "");
    if (youtubeVideoResult != null &&
        youtubeVideoResult.items != null &&
        youtubeVideoResult.items!.length > 0) {
      youtubeResult.update((val) {
        val!.nextPagetoken = youtubeVideoResult.nextPagetoken;
        val.items!.addAll(youtubeVideoResult.items ?? []);
      });
    }
  }
}
