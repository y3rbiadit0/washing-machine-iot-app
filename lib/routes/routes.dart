class RouteData {
  const RouteData({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;
}

enum AppRoutes { homepage, login_page, reservation_page, scan_qr_page_start }

extension AppRoutesExtension on AppRoutes {
  RouteData get details {
    switch (this) {
      case AppRoutes.homepage:
        return const RouteData(name: "homepage", path: "/");
      case AppRoutes.login_page:
        return const RouteData(name: "login_page", path: "/login");
      case AppRoutes.reservation_page:
        return const RouteData(name: "reservation_page", path: "/reservation");
      case AppRoutes.scan_qr_page_start:
        return const RouteData(name: "scan_qr_start", path: "/start");
    }
  }
}
