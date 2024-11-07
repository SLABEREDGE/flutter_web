import '../main.dart';
import 'home_screen_controller.dart';

void singletonSetup() {
  getIt.registerSingleton<HomeScreenController>(HomeScreenController());
}
