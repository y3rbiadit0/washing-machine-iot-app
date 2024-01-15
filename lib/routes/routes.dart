class RouteData {
  const RouteData({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;
}

enum AppRoutes {
  homepage,
  login_page,
  reservation_page,
  load_your_clothes,
  get_your_clothes
}

extension AppRoutesExtension on AppRoutes {
  RouteData get details {
    switch (this) {
      case AppRoutes.homepage:
        return const RouteData(name: "homepage", path: "/");
      case AppRoutes.login_page:
        return const RouteData(name: "login_page", path: "/login");
      case AppRoutes.reservation_page:
        return const RouteData(name: "reservation_page", path: "/reservation");
      case AppRoutes.load_your_clothes:
        return const RouteData(
            name: "load_your_clothes", path: "/load_your_clothes");
      case AppRoutes.get_your_clothes:
        return const RouteData(
            name: "get_your_clothes", path: "/get_your_clothes");
    }
  }
}
