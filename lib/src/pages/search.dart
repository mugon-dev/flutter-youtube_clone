import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/src/controller/youtube_search_controller.dart';

class YoutubeSearch extends GetView<YoutubeSearchController> {
  const YoutubeSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/svg/icons/back.svg'),
          onPressed: () => Get.back(),
        ),
        title: TextField(
          decoration: InputDecoration(
              fillColor: Colors.grey.withOpacity(0.2),
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(5),
              )),
          onSubmitted: (value) {
            controller.search(value);
          },
        ),
      ),
      body: _searchHistory(),
    );
  }

  Widget _searchHistory() {
    return Obx(
      () => ListView(
        children: List.generate(
            controller.history.length,
            (index) => ListTile(
                  leading: SvgPicture.asset(
                    'assets/svg/icons/wall-clock.svg',
                    width: 20,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(controller.history[index]),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                )).toList(),
      ),
    );
  }
}
