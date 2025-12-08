import 'package:get/get.dart';

import '../modules/buyer_order_details/bindings/buyer_order_details_binding.dart';
import '../modules/buyer_order_details/views/buyer_order_details_view.dart';
import '../modules/buyer_orders_list/bindings/buyer_orders_list_binding.dart';
import '../modules/buyer_orders_list/views/buyer_orders_list_view.dart';
import '../modules/create_dispute/bindings/create_dispute_binding.dart';
import '../modules/create_dispute/views/create_dispute_view.dart';
import '../modules/create_order/bindings/create_order_binding.dart';
import '../modules/create_order/views/create_order_view.dart';
import '../modules/create_password/bindings/create_password_binding.dart';
import '../modules/create_password/views/create_password_view.dart';
import '../modules/create_submission/bindings/create_submission_binding.dart';
import '../modules/create_submission/views/create_submission_view.dart';
import '../modules/disputes/bindings/disputes_binding.dart';
import '../modules/disputes/views/disputes_view.dart';
import '../modules/face_id/bindings/face_id_binding.dart';
import '../modules/face_id/views/face_id_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_buyer/bindings/home_buyer_binding.dart';
import '../modules/home_buyer/views/home_buyer_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/loyalty_points/bindings/loyalty_points_binding.dart';
import '../modules/loyalty_points/views/loyalty_points_view.dart';
import '../modules/my_orders/bindings/my_orders_binding.dart';
import '../modules/my_orders/views/my_orders_view.dart';
import '../modules/notification_detail/bindings/notification_detail_binding.dart';
import '../modules/notification_detail/views/notification_detail_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/order_details/bindings/order_details_binding.dart';
import '../modules/order_details/views/order_details_view.dart';
import '../modules/order_tracking/bindings/order_tracking_binding.dart';
import '../modules/order_tracking/views/order_tracking_view.dart';
import '../modules/orders/bindings/orders_binding.dart';
import '../modules/orders/views/orders_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/register_seller/bindings/register_seller_binding.dart';
import '../modules/register_seller/views/register_seller_view.dart';
import '../modules/role_selection/bindings/role_selection_binding.dart';
import '../modules/role_selection/views/role_selection_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/submissions/bindings/submissions_binding.dart';
import '../modules/submissions/views/submissions_view.dart';
import '../modules/touch_id_auth/bindings/touch_id_auth_binding.dart';
import '../modules/touch_id_auth/views/touch_id_auth_view.dart';
import '../modules/touch_id_verify/bindings/touch_id_verify_binding.dart';
import '../modules/touch_id_verify/views/touch_id_verify_view.dart';
import '../modules/verification/bindings/verification_binding.dart';
import '../modules/verification/views/verification_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ROLE_SELECTION,
      page: () => RoleSelectionView(),
      binding: RoleSelectionBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATION,
      page: () => VerificationView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PASSWORD,
      page: () => CreatePasswordView(),
      binding: CreatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FACE_ID,
      page: () => FaceIdView(),
      binding: FaceIdBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_SELLER,
      page: () => const RegisterSellerView(),
      binding: RegisterSellerBinding(),
    ),
    GetPage(
      name: _Paths.TOUCH_ID_AUTH,
      page: () => const TouchIdAuthView(),
      binding: TouchIdAuthBinding(),
    ),
    GetPage(
      name: _Paths.TOUCH_ID_VERIFY,
      page: () => const TouchIdVerifyView(),
      binding: TouchIdVerifyBinding(),
    ),
    GetPage(
      name: _Paths.SUBMISSIONS,
      page: () => const SubmissionsView(),
      binding: SubmissionsBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_SUBMISSION,
      page: () => const CreateSubmissionView(),
      binding: CreateSubmissionBinding(),
    ),
    GetPage(
      name: _Paths.ORDERS,
      page: () => const OrdersView(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAILS,
      page: () => const OrderDetailsView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: _Paths.MY_ORDERS,
      page: () => const MyOrdersView(),
      binding: MyOrdersBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_TRACKING,
      page: () => const OrderTrackingView(),
      binding: OrderTrackingBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.HOME_BUYER,
      page: () => const HomeBuyerView(),
      binding: HomeBuyerBinding(),
    ),
    GetPage(
      name: _Paths.BUYER_ORDERS_LIST,
      page: () => const BuyerOrdersListView(),
      binding: BuyerOrdersListBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_ORDER,
      page: () => const CreateOrderView(),
      binding: CreateOrderBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () =>   PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.BUYER_ORDER_DETAILS,
      page: () => const BuyerOrderDetailsView(),
      binding: BuyerOrderDetailsBinding(),
    ),
    GetPage(
      name: _Paths.DISPUTES,
      page: () => const DisputesView(),
      binding: DisputesBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_DISPUTE,
      page: () => const CreateDisputeView(),
      binding: CreateDisputeBinding(),
    ),
    GetPage(
      name: _Paths.LOYALTY_POINTS,
      page: () => const LoyaltyPointsView(),
      binding: LoyaltyPointsBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_DETAIL,
      page: () => const NotificationDetailView(),
      binding: NotificationDetailBinding(),
    ),
  ];
}
