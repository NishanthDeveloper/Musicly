import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../../../core/theme/app_pallete.dart';

class AudioWave extends StatefulWidget {
  final String path;

  const AudioWave({super.key, required this.path});

  @override
  State<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {
  final PlayerController playerController = PlayerController();

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  // Method to check if the file exists and load it into the player
  void initAudioPlayer() async {
    try {
      final file = File(widget.path);
      bool exists = await file.exists();

      if (!exists) {
        print('Error: The file does not exist at the specified path');
        return;
      }

      await playerController.preparePlayer(
        path: widget.path, // path to the audio file
        shouldExtractWaveform: true,
      );
      print('Player prepared successfully!');
    } catch (e) {
      print("Error preparing player: $e");
    }
  }

  // Play or Pause the audio
  Future<void> playAndPause() async {
    try {
      if (!playerController.playerState.isPlaying) {
        await playerController.startPlayer(); // Start playing the audio
      } else {
        await playerController.pausePlayer(); // Pause the audio
      }
      setState(() {});
    } catch (e) {
      print('Error playing or pausing audio: $e');
    }
  }

  @override
  void dispose() {
    playerController.dispose(); // Dispose the player when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: playAndPause,
          icon: Icon(
            playerController.playerState.isPlaying
                ? CupertinoIcons.pause_solid
                : CupertinoIcons.play_arrow_solid,
          ),
        ),
        Expanded(
          child: AudioFileWaveforms(
            size: const Size(double.infinity, 100),
            playerController: playerController,
            playerWaveStyle: const PlayerWaveStyle(
              fixedWaveColor: Pallete.borderColor,
              liveWaveColor: Pallete.gradient2,
              spacing: 6,
              showSeekLine: false,
            ),
           
          ),
        ),
      ],
    );
  }
}
