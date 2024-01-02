import 'dart:math';

class BookImages {
  static String root = "assets/myImages";

  static String errorIcons = "$root/error_icons.json";
  static String successJson = "$root/success.json";
  static String mic = "$root/mic.png";
  static String collection5 = "$root/collection5.png";
  static String collection4 = "$root/collection4.png";
  static String collection3 = "$root/collection3.png";
  static String collection2 = "$root/collection2.png";
  static String collection1 = "$root/collection1.png";
  static String subscriptionIcon = "$root/subscription_icon.png";
  static String audioPlayer = "$root/audio_player.png";
  static String readerIcon = "$root/reader_icon.png";
  static String subscription = "$root/subscription.png";
  static String manageCard = "$root/manage_card.png";
  static String changePassword = "$root/change_password.png";
  static String fa_legal = "$root/fa_legal_.png";
  static String contact_us = "$root/contact_us.png";
  static String delete_icon = "$root/delete_icon.png";
  static String camera_icon = "$root/camera_icon.png";
  static String all_user = "$root/all_user.png";
  static String noSavedCard = "$root/no_saved_card.png";
  static String imagePicker = "$root/image_picker.png";
  static String videoPicker = "$root/video_picker.png";
  static String like = "$root/like.png";
  static String comment = "$root/comment.png";
  static String voiceNote = "$root/voice_note.json";
  static String readBook = "$root/read_book.png";
  static String homeIcon = "$root/home_icon.png";
  static String logoIcon = "$root/logo_icon.png";
  static String explore = "$root/explore.png";
  static String community = "$root/community.png";
  static String fingerPrint = "$root/finger_print.png";
  static String faceID = "$root/face.jpg";
  static String premium_access = "$root/premium_access.png";
  static String saved_cards = "$root/saved_cards.png";
  static String pay_pal = "$root/pay_pal.png";
  static String card_payment = "$root/card_payment.png";
  static String empty_list = "$root/empty_list.png";

  List<String> collections = [
    collection1,
    collection2,
    collection3,
    collection4,
    collection5
  ];
  String getCollection() {
    return collections[Random().nextInt(5)];
  }
}
