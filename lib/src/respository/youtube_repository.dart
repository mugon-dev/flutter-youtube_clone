import 'package:get/get.dart';
import 'package:youtube_clone/src/models/statistics.dart';
import 'package:youtube_clone/src/models/youtube_video_result.dart';
import 'package:youtube_clone/src/models/youtuber.dart';

class YoutubeRepository extends GetConnect {
  static YoutubeRepository get to => Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    httpClient.baseUrl = 'https://www.googleapis.com';
    super.onInit();
  }

  Future<YoutubeVideoResult?> loadVideos(String nextPageToken) async {
    String url =
        '/youtube/v3/search?part=snippet&channelId=UCbMGBIayK26L4VaFrs5jyBw&maxResults=10&order=date&type=video&videoDefinition=high&key=AIzaSyDagbzNCisB2k0xKHgmTw5WehY_2SNq9Jk&pageToken=$nextPageToken';
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      if (response.body['items'] != null && response.body['items'].length > 0) {
        return YoutubeVideoResult.fromJson(response.body);
      }
    }
  }

  Future<YoutubeVideoResult?> search(
      String searchKeyword, String nextPageToken) async {
    String url =
        '/youtube/v3/search?part=snippet&maxResults=10&order=date&type=video&videoDefinition=high&key=AIzaSyDagbzNCisB2k0xKHgmTw5WehY_2SNq9Jk&pageToken=$nextPageToken&q=$searchKeyword';
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      if (response.body['items'] != null && response.body['items'].length > 0) {
        return YoutubeVideoResult.fromJson(response.body);
      }
    }
  }

  Future<Statistics?> getVideoInfoById(String videoId) async {
    String url =
        '/youtube/v3/videos?part=snippet,statistics&key=AIzaSyDagbzNCisB2k0xKHgmTw5WehY_2SNq9Jk&id=$videoId';
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      if (response.body['items'] != null && response.body['items'].length > 0) {
        Map<String, dynamic> data = response.body['items'][0];
        return Statistics.fromJson(data['statistics']);
      }
    }
  }

  Future<Youtuber?> getYoutuberInfoById(String channelId) async {
    String url =
        '/youtube/v3/channels?part=statistics,snippet&key=AIzaSyDagbzNCisB2k0xKHgmTw5WehY_2SNq9Jk&id=$channelId';
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      if (response.body['items'] != null && response.body['items'].length > 0) {
        Map<String, dynamic> data = response.body['items'][0];
        return Youtuber.fromJson(data);
      }
    }
  }
}
