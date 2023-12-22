// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../Widget/linear_indicator.dart';
import '../../Widget/textFiealds2.dart';
import '../../data_layer/controller/searchbook_controller.dart';
import '../../data_layer/manager/manager.dart';
import '../../data_layer/models/search_book_response.dart';
import '../../utils/page_state.dart';
import '../../utils/scaffold/custom_scaffold.dart';
import '../widget/shimmer_widget.dart';
import '9_FROM_HELL.dart';

class SerchScreen extends ConsumerStatefulWidget {
  const SerchScreen({super.key});

  @override
  ConsumerState<SerchScreen> createState() => _SerchScreenState();
}

class _SerchScreenState extends ConsumerState<SerchScreen> {
  late SearchBookController controller;
  @override
  Widget build(BuildContext context) {
    controller = ref.watch(searchBookManager);
    return CustomScaffold(
      body: Container(
        color: Colors.grey.withOpacity(0.05),
        child: Padding(
          padding: EdgeInsets.only(
              left: 18,
              right: 18,
              top: MediaQuery.of(context).padding.top + 16,
              bottom: MediaQuery.of(context).padding.bottom),
          child: Column(
            children: [
              BookLinearProgressBar(
                isloading: controller.pageState == PageState.loading,
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyTextFieald2(
                      hintText: "Search",
                      suffixIcon: IconButton(
                        icon: Icon(
                          CupertinoIcons.search,
                          color: Colors.grey,
                          size: 15,
                        ),
                        onPressed: () {},
                      ),
                      onChange: (v) {
                        controller.setSearchQuery(v);
                      },
                    ),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 12,
                            color: Theme.of(context).disabledColor,
                          ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.searchBookResponse?.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return _SearchView(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FromHellScreen(
                              bookID: controller
                                  .searchBookResponse?.data?[index].id,
                            ),
                          ),
                        );
                      },
                      fullBookData: controller.searchBookResponse!.data![index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchView extends StatelessWidget {
  final FullBookData fullBookData;
  final VoidCallback? onTap;
  const _SearchView({Key? key, required this.fullBookData, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              height: 150,
              imageUrl: fullBookData.images ?? "",
              placeholder: (context, url) => ShimmerWidget(
                height: 150,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullBookData.title ?? "",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 14,
                      ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  fullBookData.author ?? "",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 12, color: Theme.of(context).disabledColor),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
