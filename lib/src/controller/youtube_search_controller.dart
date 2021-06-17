import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_clone/src/models/youtube_video_result.dart';
import 'package:youtube_clone/src/respository/youtube_repository.dart';

class YoutubeSearchController extends GetxController {
  String key = 'SearchKey';
  // RxList 초기화 또는 [""].obs 로 대체 가능
  RxList<String> history = RxList<String>.empty(growable: true);
  late SharedPreferences _profs;
  Rx<YoutubeVideoResult> youtubeVideoResult = YoutubeVideoResult(items: []).obs;
  // infinity scroll
  ScrollController scrollController = ScrollController();
  late String _currentKeyword;

  @override
  void onInit() async {
    // local storage를 통해 관리
    _profs = await SharedPreferences.getInstance();
    List<dynamic> initData = _profs.get(key) as List;
    history(initData.map((_) => _.toString()).toList());
    _event();
    super.onInit();
  }

  void submitSearch(String search) {
    //add if 를 통해 넣을 값이 존재하지 않으면 저
    history.addIf(!history.contains(search), search);
    _profs.setStringList(key, history.toList());
    _currentKeyword = search;
    _searchYoutube(search);
  }

  void _searchYoutube(String searchKey) async {
    YoutubeVideoResult? youtubeVideoResultFromServer = await YoutubeRepository
        .to
        .search(searchKey, youtubeVideoResult.value.nextPagetoken ?? "");
    if (youtubeVideoResultFromServer != null &&
        youtubeVideoResultFromServer.items != null &&
        youtubeVideoResultFromServer.items!.length > 0) {
      youtubeVideoResult.update((val) {
        val!.nextPagetoken = youtubeVideoResultFromServer.nextPagetoken;
        val.items!.addAll(youtubeVideoResultFromServer.items ?? []);
      });
    }
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
          youtubeVideoResult.value.nextPagetoken != "") {
        _searchYoutube(_currentKeyword);
      }
    });
  }
}
