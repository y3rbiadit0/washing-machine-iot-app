enum AppRoutes {
  homepage(name: "homepage", path: "/"),
  login_page(name: "login_page", path: "/login");

  const AppRoutes({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;

}