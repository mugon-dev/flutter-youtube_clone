import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YoutubeSearchController extends GetxController {
  String key = 'SearchKey';
  // RxList 초기화 또는 [""].obs 로 대체 가능
  RxList<String> history = RxList<String>.empty(growable: true);
  late SharedPreferences _profs;

  @override
  void onInit() async {
    // local storage를 통해 관리
    _profs = await SharedPreferences.getInstance();
    List<dynamic> initData = _profs.get(key) as List;
    history(initData.map((_) => _.toString()).toList());

    super.onInit();
  }

  void search(String search) {
    //add if 를 통해 넣을 값이 존재하지 않으면 저
    history.addIf(!history.contains(search), search);
    _profs.setStringList(key, history.toList());
  }
}
