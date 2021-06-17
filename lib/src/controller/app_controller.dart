import 'package:get/get.dart';

// 페이지 이동용 페이지 명 정의
enum RouteName { Home, Explore, Add, Subs, Library }

// 바텀 네비게이션에 영속성 부여
// 선언 후 바인딩 필요 main에서 initialBinding (앱 실행동안 쓰이는 컨트롤러이기 때문)
class AppController extends GetxService {
  // Get.find() 쉽게 사용
  static AppController get to => Get.find();

  RxInt currentIndex = 0.obs;

  void changePageIndex(int index) {
    currentIndex(index);
  }
}
