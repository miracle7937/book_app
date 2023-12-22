import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_layer/models/user_response.dart';
import '../utils/images.dart';
import '../utils/scaffold/custom_scaffold.dart';

import '../data_layer/controller/profile_controller.dart';
import '../data_layer/manager/manager.dart';
import '../utils/dialog/snack_bars.dart';
import '../utils/local_storage_data.dart';

class SavedCardScreen extends ConsumerStatefulWidget {
  const SavedCardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SavedCardScreen> createState() => _SavedCardScreenState();
}

class _SavedCardScreenState extends ConsumerState<SavedCardScreen>
    implements ManageCardView {
  late ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    profileController = ref.watch(profileBookManager)..setManageView(this);
    return CustomScaffold(
        pageState: profileController.pageState,
        appBar: AppBar(
          iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
          title: Text(
            "Manage Debit / Credit Cards",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: FutureBuilder<UserData?>(
            future: LocalDataStorage.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.data?.savedCard == null) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Image.asset(BookImages.noSavedCard)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("No Saved Cards")
                      ],
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data?.savedCard?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    UserCard? userCard = snapshot.data!.savedCard?[index];
                    return ShadowListTile(
                      onTap: () {
                        profileController.deleteCard(userCard?.id);
                      },
                      title: userCard?.name ?? "",
                      subtitle:
                          "${userCard?.brand}  | **** **** **** ${userCard?.last4}",
                    );
                  },
                ),
              );
            }));
  }

  @override
  onError(String error) {
    errorSnack(context, error);
  }

  @override
  onSuccess(String message) {
    successSnack(context, message);
  }
}

class ShadowListTile extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final String subtitle;

  ShadowListTile({
    this.title = "",
    this.subtitle = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        elevation: 4.0,
        child: ClipRect(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              leading: SizedBox(
                height: 30,
                child: Image.asset(BookImages.noSavedCard),
              ),
              title: Text(title),
              subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
              trailing: InkWell(
                onTap: onTap,
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
