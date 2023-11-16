import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fox/data/model/blog/blog_model.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/services/blog/blog_service.dart';

class BlogListPageController extends GetxController {
  RefreshController refreshController = RefreshController(initialRefresh: true);
  Map<String, dynamic> requestParmas = {};
  var first = 30;
  PageInfo? pageInfo;
  List<BlogModel> blogList = [];

  onRefresh({LoadingType loadingType = LoadingType.none}) async {
    refreshController.resetNoData();
    requestParmas = {
      "first": first,
    };

    BlogList result = await BlogService()
        .getBlogList(requestParmas, loadingType: loadingType);
    blogList = [];
    var tempList = result.value ?? [];
    blogList.addAll(tempList);
    pageInfo = result.pageInfo;
    update();

    refreshController.refreshCompleted();
  }

  onLoading() async {
    requestParmas = {
      "first": first,
      "after": pageInfo?.endCursor,
    };

    BlogList result = await BlogService().getBlogList(requestParmas);
    var tempList = result.value ?? [];
    blogList.addAll(tempList);
    pageInfo = result.pageInfo;
    update();

    refreshController.loadComplete();

    if (pageInfo?.hasNextPage == false) {
      refreshController.loadNoData();
    }
  }
}
