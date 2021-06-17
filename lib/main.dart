import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/src/app.dart';
import 'package:youtube_clone/src/binding/init_binding.dart';
import 'package:youtube_clone/src/components/youtube_detail.dart';
import 'package:youtube_clone/src/controller/youtube_detail_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Youtube Clone App',
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // 앱 전체에서 사용되는 바인딩
      initialBinding: InitBinding(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => App()),
        GetPage(
          name: "/detail/:videoId",
          page: () => YoutubeDetail(),
          binding: BindingsBuilder(
            () => Get.lazyPut<YoutubeDetailController>(
                () => YoutubeDetailController()),
          ),
        ),
      ],
    );
  }
}
