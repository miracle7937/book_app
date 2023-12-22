import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/music_player_util/music_controller.dart';
import '../controller/communityController.dart';
import '../controller/community_post_controller.dart';
import '../controller/home_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/registraion_controller.dart';
import '../controller/searchbook_controller.dart';
import '../controller/subscribe_controller.dart';

final registrationController =
    ChangeNotifierProvider<RegistrationController>((ref) {
  return RegistrationController();
});

final homeControllerManager = ChangeNotifierProvider<HomeController>((ref) {
  return HomeController();
});

final searchBookManager = ChangeNotifierProvider<SearchBookController>((ref) {
  return SearchBookController();
});
final profileBookManager = ChangeNotifierProvider<ProfileController>((ref) {
  return ProfileController();
});
final communityManager = ChangeNotifierProvider<CommunityController>((ref) {
  return CommunityController();
});

final videoUploadProvider = ChangeNotifierProvider<VideoUploadNotifier>(
  (_) => VideoUploadNotifier(),
);
final musicManager = ChangeNotifierProvider<MusicController>(
  (_) => MusicController(),
);
final subscribeManager = ChangeNotifierProvider<SubscribeController>(
  (_) => SubscribeController(),
);
