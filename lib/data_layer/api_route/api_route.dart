class ApiRoute {
  static String BaseRoute = "http://sidecampus.com";
  static String registration = "$BaseRoute/api/register";
  static String home = "$BaseRoute/api/home";
  static String login = "$BaseRoute/api/login";
  static String sendOTP = "$BaseRoute/api/verify-email";
  static String forgetPassword = "$BaseRoute/api/forgot-password";
  static String resendOTP = "$BaseRoute/api/resend-otp-code";
  static String verifyOTP = "$BaseRoute/api/verify-email-otp";

  static String view_book = "$BaseRoute/api/view-book";
  static String addFavorite = "$BaseRoute/api/add-favorite";
  static String readBook = "$BaseRoute/api/read-book";
  static String playAudio = "$BaseRoute/api/play-audio";
  static String addRating = "$BaseRoute/api/add-review";
  static String searchBook = "$BaseRoute/api/search";
  static String getByCategory = "$BaseRoute/api/get-by-category";
  static String updateUser = "$BaseRoute/api/update-user";
  static String contactUs = "$BaseRoute/api/contact-us";
  static String legal = "$BaseRoute/api/legal";
  static String deleteAccount = "$BaseRoute/api/delete-account";
  static String logOut = "$BaseRoute/api/logout";
  static String deleteCard = "$BaseRoute/api/delete-card";
  static String getUser = "$BaseRoute/api/get-user";
  static String post = "$BaseRoute/api/post";
  static String unlikePost = "$BaseRoute/api/unlike-post";
  static String likePost = "$BaseRoute/api/like-post";
  static String deleteComment = "$BaseRoute/api/delete-comment";
  static String deletePost = "$BaseRoute/api/delete-post";
  static String post_sub_comment = "$BaseRoute/api/post-sub-comment";
  static String comment = "$BaseRoute/api/comment";
  static String open_post = "$BaseRoute/api/open-post";
  static String postContent = "$BaseRoute/api/post";
  static String subscribe = "$BaseRoute/api/subscribe";
  static String subscribe_savedCards =
      "$BaseRoute/api/subscribe-with-savedcards";
  static String stripeWebHook = "$BaseRoute/api/webhook";
  static String allPost(int value) => "$BaseRoute/api/all-post/$value";
  static String getMyPost(int value) => "$BaseRoute/api/my-post/$value";
}
