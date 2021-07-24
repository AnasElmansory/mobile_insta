import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  final RxBool _loading = true.obs;
  final RxBool _showPreviewImage = true.obs;
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool get loading => _loading.value;
  bool get showPreviewImage => _showPreviewImage.value;
  ChewieController get chewieController => _chewieController;

  void getVideo(String? videoUrl) async {
    if (videoUrl == null) {
      return;
    } else {
      _videoPlayerController = VideoPlayerController.network(videoUrl);
      await _videoPlayerController.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        showControls: true,
        showOptions: true,
        showControlsOnInitialize: true,
      );
      _showPreviewImage.value = false;
    }
  }

  @override
  void onClose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    print('controller closed');
    super.onClose();
  }
}
