import 'package:get/get.dart';

import 'package:pet_care/app/modules/adoption/bindings/adoption_binding.dart';
import 'package:pet_care/app/modules/adoption/views/adoption_view.dart';
import 'package:pet_care/app/modules/appointment_detail/bindings/appointment_detail_binding.dart';
import 'package:pet_care/app/modules/appointment_detail/views/appointment_detail_view.dart';
import 'package:pet_care/app/modules/appointment_list/bindings/appointment_list_binding.dart';
import 'package:pet_care/app/modules/appointment_list/views/appointment_list_view.dart';
import 'package:pet_care/app/modules/appointments/bindings/appointments_binding.dart';
import 'package:pet_care/app/modules/appointments/views/appointments_view.dart';
import 'package:pet_care/app/modules/cart/bindings/cart_binding.dart';
import 'package:pet_care/app/modules/cart/views/cart_view.dart';
import 'package:pet_care/app/modules/checkout/bindings/checkout_binding.dart';
import 'package:pet_care/app/modules/checkout/views/checkout_view.dart';
import 'package:pet_care/app/modules/detail/bindings/detail_binding.dart';
import 'package:pet_care/app/modules/detail/views/detail_view.dart';
import 'package:pet_care/app/modules/home/bindings/home_binding.dart';
import 'package:pet_care/app/modules/home/views/home_view.dart';
import 'package:pet_care/app/modules/initial/bindings/initial_binding.dart';
import 'package:pet_care/app/modules/initial/views/initial_view.dart';
import 'package:pet_care/app/modules/notification/bindings/notification_binding.dart';
import 'package:pet_care/app/modules/notification/views/notification_view.dart';
import 'package:pet_care/app/modules/notifications/bindings/notifications_binding.dart';
import 'package:pet_care/app/modules/notifications/views/notifications_view.dart';
import 'package:pet_care/app/modules/order/bindings/order_binding.dart';
import 'package:pet_care/app/modules/order/views/order_view.dart';
import 'package:pet_care/app/modules/orders/bindings/orders_binding.dart';
import 'package:pet_care/app/modules/orders/views/orders_view.dart';
import 'package:pet_care/app/modules/product/bindings/product_binding.dart';
import 'package:pet_care/app/modules/product/views/product_view.dart';
import 'package:pet_care/app/modules/profile/bindings/profile_binding.dart';
import 'package:pet_care/app/modules/profile/views/profile_view.dart';
import 'package:pet_care/app/modules/settings/bindings/settings_binding.dart';
import 'package:pet_care/app/modules/settings/views/settings_view.dart';
import 'package:pet_care/app/modules/welcome/bindings/welcome_binding.dart';
import 'package:pet_care/app/modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENTS,
      page: () => AppointmentsView(),
      binding: AppointmentsBinding(),
    ),
    GetPage(
      name: _Paths.ADOPTION,
      page: () => AdoptionView(),
      binding: AdoptionBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.ORDERS,
      page: () => OrdersView(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.INITIAL,
      page: () => InitialView(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENT_LIST,
      page: () => AppointmentListView(),
      binding: AppointmentListBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENT_DETAIL,
      page: () => AppointmentDetailView(),
      binding: AppointmentDetailBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
  ];
}
