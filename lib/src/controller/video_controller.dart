import 'package:get/get.dart';
import 'package:youtube_clone/src/models/statistics.dart';
import 'package:youtube_clone/src/models/video.dart';
import 'package:youtube_clone/src/models/youtuber.dart';
import 'package:youtube_clone/src/respository/youtube_repository.dart';

class VideoController extends GetxController {
  Video? video;
  VideoController({this.video});
  Rx<Statistics> statistics = Statistics().obs;
  Rx<Youtuber> youtuber = Youtuber().obs;

  @override
  void onInit() async {
    Statistics? loadStatistics = await YoutubeRepository.to
        .getVideoInfoById(video!.id!.videoId.toString());
    statistics(loadStatistics);
    Youtuber? loadyoutuber = await YoutubeRepository.to
        .getYoutuberInfoById(video!.snippet!.channelId.toString());
    youtuber(loadyoutuber);
    super.onInit();
  }

  String get viewCountString => "조회수 ${statistics.value.viewCount ?? '-'}회";
  String get youtuberThumbnailUrl {
    if (youtuber.value.snippet! == null)
      return "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png";
    return youtuber.value.snippet!.thumbnails!.medium!.url.toString();
  }
}
