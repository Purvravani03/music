import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Controller extends GetxController
{
  RxBool player=true.obs;
  List<SongModel> SongList=[];
  final OnAudioQuery _audioQuery = OnAudioQuery();
  Future<List <SongModel>> GetSong() async {
    SongList.clear();
    SongList=await _audioQuery.querySongs();
    return SongList;
  }
  String printDuration(Duration duration){
    String twodigit(int b){
      if(b>=10) return "$b";
      return "$b";
    }
    String twodgitMinite=twodigit(duration.inMinutes.remainder(60));
    String twodgitsecond=twodigit(duration.inSeconds.remainder(60));
    if(duration.inHours>0)
      return "${twodigit(duration.inHours)}:$twodgitMinite:$twodgitsecond";
    else
      return"$twodgitMinite:$twodgitsecond";
  }
}