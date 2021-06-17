import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:youtube_clone/src/controller/video_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeDetailController extends GetxController {
  VideoController? videoController;
  YoutubePlayerController? playerController;
  @override
  void onInit() {
    // video_widget의 컨트롤러 생성할때 tag를 기준으로 생성했었으니 tag를 기반으로 데이터를 찾
    videoController = Get.find(tag: Get.parameters['videoId']);
    playerController = YoutubePlayerController(
      initialVideoId: Get.parameters['videoId'].toString(),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
    super.onInit();
  }

  String get title => videoController!.video!.snippet!.title.toString();
  String get viewCount => '조회수 ${videoController!.statistics.value.viewCount}';
  String get publishedTime => DateFormat("yyyy-MM-dd")
      .format(videoController!.video!.snippet!.publishTime!);
  String get discription => videoController!.video!.snippet!.description!;
  String get likeCount => '${videoController!.statistics.value.likeCount}';
  String get disLikeCount =>
      '${videoController!.statistics.value.dislikeCount}';
  String get youtuberThumbnailUrl => videoController!.youtuberThumbnailUrl;
  String get youtuberName => videoController!.youtuber.value.snippet!.title!;
}
