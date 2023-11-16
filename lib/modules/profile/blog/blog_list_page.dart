import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fox/data/model/blog/blog_model.dart';
import 'package:fox/modules/profile/blog/blog_list_page_controller.dart';
import 'package:fox/routes/routers.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/refresh_loading_widget.dart';

class BlogListPage extends GetView<BlogListPageController> {
  @override
  final BlogListPageController controller = Get.put(BlogListPageController());

  BlogListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BlogListPageController>(
      builder: (_) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Blog',
          ),
          body: buildRefresh(),
        );
      },
    );
  }

  Widget buildRefresh() {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: const ClassicHeader(
        completeIcon: SizedBox(),
        completeDuration: Duration(milliseconds: 50),
        completeText: '',
        idleIcon: Icon(
          Icons.arrow_downward_rounded,
          color: Colors.grey,
        ),
        idleText: 'Pull down to refresh',
        refreshingIcon: RefreshLoading(),
      ),
      footer: const ClassicFooter(
        loadingIcon: RefreshLoading(),
      ),
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      child: buildList(),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: controller.blogList.length,
      itemBuilder: (context, index) {
        var item = controller.blogList[index];
        return buildItem(item);
      },
    );
  }

  Widget buildItem(BlogModel item) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRouters.blogDetailPage,
          arguments: {
            'title': item.title,
            'url': item.articles?.first.onlineStoreUrl,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: AppColors.GREY_F5F5F5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.title ?? '',
                  style: AppTextStyle.Black14,
                ),
                const Text(
                  'See More →',
                  style: AppTextStyle.Grey12_9E9E9E,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              item.articles?.first.title ?? '',
              style: AppTextStyle.Grey12_9E9E9E,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              item.articles?.first.content ?? '',
              style: AppTextStyle.Grey14_757575,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
