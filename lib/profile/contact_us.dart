import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/scaffold/custom_scaffold.dart';

import '../data_layer/controller/profile_controller.dart';
import '../data_layer/manager/manager.dart';
import '../utils/native_launcher.dart';

class ContactUs extends ConsumerStatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  ConsumerState<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends ConsumerState<ContactUs>
    implements ContactUseView {
  bool isLoading = true;
  late ProfileController profileController;

  @override
  void dispose() {
    super.dispose();

    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    profileController = ref.watch(profileBookManager)..setContactUs(this);
    if (isLoading) {
      profileController.contactUs();
      isLoading = false;
    }

    return CustomScaffold(
        pageState: profileController.pageState,
        appBar: AppBar(
          iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
          title: Text(
            'Contact Us',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                  "Do you have any questions? Contact us to the following email, we will be more than happy to help you"),
              SizedBox(
                height: 20,
              ),
              Material(
                borderRadius: BorderRadius.circular(8),
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: ListTile(
                    title: Text("Start a call with support"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          profileController.contactUsModel?.data?.phoneNo ?? "",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    trailing: InkWell(
                      onTap: () => launchContactMethod(ContactMethod.phone,
                          profileController.contactUsModel?.data?.phoneNo),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Material(
                borderRadius: BorderRadius.circular(8),
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: ListTile(
                    title: Text("Send us an Email"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          profileController.contactUsModel?.data?.email ?? "",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    trailing: InkWell(
                      onTap: () => launchContactMethod(ContactMethod.email,
                          profileController.contactUsModel?.data?.email),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  @override
  onError(String error) {}

  @override
  onSuccess(String message) {}
}
