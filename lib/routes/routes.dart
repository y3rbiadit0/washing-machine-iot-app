enum AppRoutes {
  homepage(name: "homepage", path: "/"),
  splash_screen(name: "splash_screen", path: "/splash");

  const AppRoutes({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;

}