
class NavigationPath {
  static final NavigationModel home = NavigationModel(name: 'Home', path: '/');
  static final NavigationModel welcomeScreen = NavigationModel(name: 'Welcome', path: '/welcome');
  static final NavigationModel intro = NavigationModel(name: 'Introduction', path: '/intro');
  static final NavigationModel splashScreen = NavigationModel(name: 'Splash', path: '/splash');
}

class NavigationModel {
  final String name;
  final String path;

  NavigationModel({required this.name, required this.path});
}