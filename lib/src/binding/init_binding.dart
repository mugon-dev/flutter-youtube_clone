import 'package:get/get.dart';
import 'package:youtube_clone/src/controller/app_controller.dart';
import 'package:youtube_clone/src/respository/youtube_repository.dart';

// main에서 최초 실행시 사용되는 컨트롤러
// Bindings 인터페이스 받아 컨트롤러 등록
class InitBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AppController());
    Get.put(YoutubeRepository(), permanent: true);
  }
}
