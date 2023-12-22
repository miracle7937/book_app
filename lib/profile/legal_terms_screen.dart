import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/scaffold/custom_scaffold.dart';

import '../data_layer/controller/profile_controller.dart';
import '../data_layer/manager/manager.dart';
import '../utils/native_launcher.dart';

class LegalTermsScreen extends ConsumerStatefulWidget {
  const LegalTermsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LegalTermsScreen> createState() => _LegalTermsScreenState();
}

class _LegalTermsScreenState extends ConsumerState<LegalTermsScreen> {
  bool isLoading = true;
  late ProfileController profileController;
  @override
  Widget build(BuildContext context) {
    profileController = ref.watch(profileBookManager);
    if (isLoading) {
      profileController.getLegalTerms();
      isLoading = false;
    }
    return CustomScaffold(
        pageState: profileController.pageState,
        appBar: AppBar(
          iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
          title: Text(
            'Legal Terms',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Material(
                borderRadius: BorderRadius.circular(8),
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: ListTile(
                    onTap: () => launchContactMethod(ContactMethod.url,
                        profileController.legalTermsModel?.data?.gdpr),
                    title: Text("GDPR Compliance Policy"),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
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
                    onTap: () => launchContactMethod(ContactMethod.url,
                        profileController.legalTermsModel?.data?.copyrite),
                    title: Text("Copyright Policy"),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
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
                    onTap: () => launchContactMethod(ContactMethod.url,
                        profileController.legalTermsModel?.data?.policy),
                    title: Text("Privacy Policy"),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
