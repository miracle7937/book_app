// // ignore_for_file: deprecated_member_use, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_layer/models/user_response.dart';
import '../data_layer/repository/profile_repository.dart';
import '../profile/saved_card_screen.dart';
import '../profile/update_screen_user.dart';
import '../profile/widget/select_image_view.dart';
import '../utils/color.dart';
import '../utils/images.dart';

import '../utils/dialog/alart_dialog.dart';
import '../utils/local_storage_data.dart';
import '../utils/themes/theme_manager.dart';
import 'contact_us.dart';
import 'legal_terms_screen.dart';

class ProfileScreem extends StatefulWidget {
  final AnimationController animationController;

  const ProfileScreem({super.key, required this.animationController});

  @override
  State<ProfileScreem> createState() => _ProfileScreemState();
}

class _ProfileScreemState extends State<ProfileScreem>
    with TickerProviderStateMixin {
  UserData? userData;
  late AnimationController _animationController;
  late ScrollController controller;
  bool isLoadingSliderDetail = false;
  var sliderImageHieght = 0.0;
  void initState() {
    loadUserData();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);
    widget.animationController.forward();
    controller = ScrollController(initialScrollOffset: 0.0);

    controller.addListener(() {
      // ignore: unnecessary_null_comparison
      if (context != null) {
        if (controller.offset < 0) {
          _animationController.animateTo(0.0);
        } else if (controller.offset > 0.0 &&
            controller.offset < sliderImageHieght) {
          if (controller.offset < ((sliderImageHieght / 1.5))) {
            _animationController
                .animateTo((controller.offset / sliderImageHieght));
          } else {
            _animationController
                .animateTo((sliderImageHieght / 1.5) / sliderImageHieght);
          }
        }
      }
    });
    loadingSliderDetail();

    super.initState();
  }

  loadingSliderDetail() async {
    setState(() {
      isLoadingSliderDetail = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      isLoadingSliderDetail = false;
    });
  }

  loadUserData() async {
    userData = await LocalDataStorage.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    sliderImageHieght = MediaQuery.of(context).size.width * 1.3;
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
            opacity: widget.animationController,
            child: Transform(
                transform: new Matrix4.translationValues(
                  0.0,
                  40 * (1.0 - widget.animationController.value),
                  0.0,
                ),
                child: Consumer(builder: (context, ref, child) {
                  return Scaffold(
                    body: Padding(
                      padding: EdgeInsets.only(
                          left: 18,
                          right: 18,
                          top: MediaQuery.of(context).padding.top + 16,
                          bottom: MediaQuery.of(context).padding.bottom),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                Row(
                                  children: [
                                    ProfileImageView(),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userData?.firstName ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                fontSize: 16,
                                              ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          userData?.email ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                fontSize: 16,
                                              ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColor.mainColor,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                            BookImages.changePassword),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => UserUpdateScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Update User",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: 14,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColor.mainColor,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child:
                                            Image.asset(BookImages.manageCard),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => SavedCardScreen(),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Manage Debit/Credit Card",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  fontSize: 14,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColor.mainColor,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child:
                                            Image.asset(BookImages.contact_us),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ContactUs(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Contact us",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: 14,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColor.mainColor,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(BookImages.fa_legal),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => LegalTermsScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Legal Terms",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: 14,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColor.mainColor,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Icon(
                                          Icons.logout,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showAlertDialog(context,
                                            title: 'Log out ?',
                                            subTitle:
                                                'Are you sure you want to Logout? ',
                                            onTap: () {
                                          RepoRepository.logOut().then((value) {
                                            //if request is true delete account
                                            if (value == true) {
                                              LocalDataStorage.clearUser();
                                              Navigator.pushNamed(context, "/");
                                            }
                                          }).onError((error, stackTrace) {
                                            LocalDataStorage.clearUser();
                                            Navigator.pushNamed(context, "/");
                                          });
                                        });
                                      },
                                      child: Text(
                                        "Logout",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: 14,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColor.mainColor,
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(BookImages.delete_icon),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  showAlertDialog(context,
                                      title: 'Delete Account?',
                                      subTitle:
                                          'Are you sure you want to delete your account? This action cannot be undone.',
                                      onTap: () {
                                    RepoRepository.deleteAccount()
                                        .then((value) {
                                      //if request is true delete account
                                      if (value == true) {
                                        LocalDataStorage.clearUser();
                                        Navigator.pushNamed(context, "/");
                                      }
                                    }).onError((error, stackTrace) {
                                      LocalDataStorage.clearUser();
                                      Navigator.pushNamed(context, "/");
                                    });
                                  });
                                },
                                child: Text(
                                  "Delete Account",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 14,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              CupertinoSwitch(
                                thumbColor: AppColor.mainColor,
                                activeColor: Colors.white,
                                value: !ref.watch(themeController).isLight,
                                onChanged: (value) {
                                  ref.watch(themeController).changeThemeData();
                                },
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text("Change Theme")
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                })));
      },
    );
  }
}
