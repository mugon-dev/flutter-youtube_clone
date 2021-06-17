import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YoutubeSearchController extends GetxController {
  String key = 'SearchKey';
  // RxList 초기화 또는 [""].obs 로 대체 가능
  RxList<String> history = RxList<String>.empty(growable: true);
  late SharedPreferences profs;
  // set을 통해 중복 처리
  Set<String> originHistory = {};

  @override
  void onInit() async {
    // local storage를 통해 관리
    profs = await SharedPreferences.getInstance();
    List<dynamic> initData = profs.get(key) as List;
    originHistory.addAll(initData.map((_) => _.toString()).toList());
    history(originHistory.toList());

    super.onInit();
  }

  void search(String search) {
    history.clear(); // history 초기화
    originHistory.add(search);
    history.addAll(originHistory.toList());
    profs.setStringList(key, history.toList());
  }
}
