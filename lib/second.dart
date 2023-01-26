import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music/dart.dart';
import 'package:on_audio_query/on_audio_query.dart';


class home extends StatelessWidget {
  Controller c = Get.put(Controller());
  final player = AudioPlayer();

  home() {
    c.GetSong();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MUSICS")),
      body: SafeArea(
        child: FutureBuilder(
          future: c.GetSong(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<SongModel> l = snapshot.data as List<SongModel>;
              return ListView.builder(itemCount: l.length,
                itemBuilder: (context, index) {
                  return ListTile(onTap: () {

                  },
                    leading: Image.asset("image/APPLE-MUSIC-removebg-preview.jpg"),
                    title: Text("${l[index].title}"),
                    subtitle: Text(c.printDuration(
                        Duration(milliseconds: l[index].duration!))),
                    trailing: Obx(() => IconButton(
                        onPressed: () async {
                          final duration =
                              await player.setFilePath(l[index].data);
                          if (c.player.value == false) {
                            await player.play();
                          }
                          else {
                            await player.pause();
                          }
                        },
                        icon: c.player.value
                            ? Icon(Icons.play_arrow)
                            : Icon(Icons.pause))),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
