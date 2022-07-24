import 'package:just_audio/just_audio.dart';

class Audio {
  final Map<String, AudioPlayer> soundPlayers = {};

  static const String SOUND_CHOLE = 'sound_chole';
  static const String SOUND_SNAKE_BITE = 'sound_snake_bite';
  static const String SOUND_SAD_TROMBONE = 'sound_sad_trombone';

  Future playSound(String sound) async {
    await stopSound(sound);
    soundPlayers[sound]?.play();
  }

  Future stopSound(String sound) async {
    await soundPlayers[sound]?.pause();
    await soundPlayers[sound]?.seek(Duration.zero);
  }

  Future load() async {
    soundPlayers[SOUND_CHOLE] = await _getPlayer(SOUND_CHOLE);
    soundPlayers[SOUND_SNAKE_BITE] = await _getPlayer(SOUND_SNAKE_BITE);
    soundPlayers[SOUND_SAD_TROMBONE] = await _getPlayer(SOUND_SAD_TROMBONE);
  }

  Future<AudioPlayer> _getPlayer(String name) async {
    final AudioPlayer player = AudioPlayer();
    await player.setAsset('assets/audio/$name.mp3');

    return player;
  }
}
