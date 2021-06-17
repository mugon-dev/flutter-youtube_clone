import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_clone/src/models/video.dart';

class VideoWidget extends StatelessWidget {
  final Video? video;
  const VideoWidget({Key? key, this.video}) : super(key: key);

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
          CircleAvatar(
            // 사이즈 조
            radius: 30,
            backgroundColor: Colors.grey.withOpacity(0.5),
            backgroundImage: Image.network(
                    "https://yt3.ggpht.com/ytc/AAUvwniU0ZOGv47lDdGSQ8H004fQgwOAJRlobuCvXwNl=s48-c-k-c0x00ffffff-no-rj")
                .image,
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
                        video!.snippet!.title!.toString(),
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
                      video!.snippet!.channelTitle!.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    Text(" · "),
                    Text(
                      "조회수 1000회",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    Text(" · "),
                    Text(
                      DateFormat('yyyy-MM-dd')
                          .format(video!.snippet!.publishedAt!),
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
        video!.snippet!.thumbnails!.medium!.url!,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
