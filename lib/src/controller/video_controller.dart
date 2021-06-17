import 'package:get/get.dart';
import 'package:youtube_clone/src/models/statistics.dart';
import 'package:youtube_clone/src/models/video.dart';
import 'package:youtube_clone/src/respository/youtube_repository.dart';

class VideoController extends GetxController {
  Video? video;
  VideoController({this.video});
  Rx<Statistics> statistics = Statistics().obs;

  @override
  void onInit() async {
    Statistics? loadStatistics = await YoutubeRepository.to
        .getVideoInfoById(video!.id!.videoId.toString());
    statistics(loadStatistics);
    super.onInit();
  }

  String get viewCountString => "조회수 ${statistics.value.viewCount ?? '-'}회";
}
