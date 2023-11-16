import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fox/data/model/enum/enum.dart';
import 'package:fox/data/model/order/order_model.dart';
import 'package:fox/modules/login/login_page_controller.dart';

class MyOrderPageController extends GetxController {
  List<OrderModel> orderList = [];
  int pageNum = 0;

  RefreshController refreshController = RefreshController();

  bool orderIsEmpty = true;
  bool historyOrderIsEmpty = true;
  var idleText = 'Pull down to refresh';
  PageStatus pageStatus = PageStatus.init;

  @override
  void onInit() {
    onRefresh();
    super.onInit();
  }

  onRefresh() {
    pageNum = 0;
    loadData();
  }

  loadMore() {
    loadData();
  }

  void loadData() async {
    await LoginController.to
        .queryCustomer(loadingType: LoadingType.transparent);
    var tempOrderList = LoginController.to.customer?.orders ?? [];
    orderList = tempOrderList.reversed.toList();
    if (orderList.isNotEmpty) {
      pageStatus = PageStatus.normal;
    } else {
      pageStatus = PageStatus.empty;
    }
    update();
  }

  refreshCompleted() {
    refreshController.refreshCompleted(resetFooterState: true);
  }

  getPaymentStatusValue(value) {
    if (value == "new") {
      return "Unpaid";
    }
    if (value == "created") {
      return "Authorized";
    }
    if (value == "approved") {
      return "Approved";
    }
    if (value == "completed") {
      return "Paid";
    }
    if (value == "canceled") {
      return "Voided";
    }
    if (value == "refunded") {
      return "Refunded";
    }
    if (value == "partialRefund") {
      return "Partial Refunded";
    }
    return value;
  }
}
