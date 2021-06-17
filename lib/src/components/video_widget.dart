import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:youtube_clone/src/controller/video_controller.dart';
import 'package:youtube_clone/src/models/video.dart';

class VideoWidget extends StatefulWidget {
  final Video? video;
  const VideoWidget({Key? key, this.video}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoController? _videoController;
  @override
  void initState() {
    // tag 를 통해 개별적으로 controller 생성 가능
    _videoController = Get.put(VideoController(video: widget.video),
        tag: widget.video!.id!.videoId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _thumbnail(),
          _simpleDetailInfo(),
        ],
      ),
    );
  }

  Widget _simpleDetailInfo() {
    return Container(
      padding: const EdgeInsets.only(left: 10, bottom: 20),
      child: Row(
        children: [
          Obx(
            () => CircleAvatar(
              // 사이즈 조
              radius: 30,
              backgroundColor: Colors.grey.withOpacity(0.5),
              backgroundImage:
                  Image.network(_videoController!.youtuberThumbnailUrl).image,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 여러 줄 처리 expanded로 감싸고 maxline
                    Expanded(
                      child: Text(
                        widget.video!.snippet!.title!.toString(),
                        maxLines: 2,
                      ),
                    ),
                    IconButton(
                      // 가운데 정
                      alignment: Alignment.topCenter,
                      onPressed: () {},
                      icon: Icon(Icons.more_vert, size: 18),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      widget.video!.snippet!.channelTitle!.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    Text(" · "),
                    Obx(
                      () => Text(
                        _videoController!.viewCountString,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ),
                    Text(" · "),
                    Text(
                      DateFormat('yyyy-MM-dd')
                          .format(widget.video!.snippet!.publishedAt!),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _thumbnail() {
    return Container(
      height: 250,
      color: Colors.grey.withOpacity(0.5),
      child: Image.network(
        widget.video!.snippet!.thumbnails!.medium!.url!,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
