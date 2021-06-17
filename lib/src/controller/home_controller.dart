//video list 불러오기
import 'package:get/get.dart';
import 'package:youtube_clone/src/models/youtube_video_result.dart';
import 'package:youtube_clone/src/respository/youtube_repository.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  Rx<YoutubeVideoResult> youtubeResult = YoutubeVideoResult().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    _videoLoad();
    super.onInit();
  }

  void _videoLoad() async {
    YoutubeVideoResult? youtubeVideoResult =
        await YoutubeRepository.to.loadVideos();
    if (youtubeVideoResult != null &&
        youtubeVideoResult.items != null &&
        youtubeVideoResult.items!.length > 0) {
      youtubeResult(youtubeVideoResult);
    }
  }
}
