import '../utils/string_helper.dart';
import 'package:url_launcher/url_launcher.dart';

launchContactMethod(ContactMethod method, String? value) async {
  if (isEmpty(value)) {
    return;
  }
  String url;

  switch (method) {
    case ContactMethod.phone:
      url = 'tel:$value'; // Replace with your phone number
      break;
    case ContactMethod.email:
      url = 'mailto:$value'; // Replace with your email address
      break;
    case ContactMethod.url:
      url = "$value";
      break;
  }
  final Uri _url = Uri.parse(url);
  if (await canLaunchUrl(_url)) {
    await launchUrl(_url);
  } else {
    throw 'Could not launch $url';
  }
}

enum ContactMethod {
  phone,
  email,
  url,
}
