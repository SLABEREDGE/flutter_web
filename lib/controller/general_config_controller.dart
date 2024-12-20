import 'package:get/get.dart';

class GeneralConfigController extends GetxController {
  RxDouble dheight = 0.0.obs;
  RxDouble dwidth = 0.0.obs;
  RxDouble safePadding = 0.0.obs;
  RxBool isDarkMode = false.obs;
  RxBool isBlurApplied = false.obs;

  // Future<void> getSelcomTheme() async {
  //   isDarkMode.value = await fetchHiveData(
  //       fieldName: DBFields.isDarkMode, defaultValue: false);
  // }

  // Hive Methods
  // Future<void> openHiveBox() async {
  //   var box = await Hive.openBox('araBox');
  //   dbBox.value = box;
  // }

  // RxBool isBoxCleard = false.obs;
  // // Hive Methods
  // Future<void> clearBox() async {
  //   isBoxCleard.value = await generalConfigController.fetchHiveData(
  //       fieldName: DBFields.isBoxCleared, defaultValue: false);
  //   log(" isBoxCleard.value  ======> ${isBoxCleard.value}");
  //   if (!isBoxCleard.value) {
  //     await dbBox.value.clear();
  //     await generalConfigController.setHiveData(
  //         fieldName: DBFields.isBoxCleared, data: true);
  //     isBoxCleard.value = true;
  //     await generalConfigController.setHiveData(
  //         fieldName: DBFields.preferredLang, data: "");
  //     preferredLang.value = "";
  //   }
  // }

  // fetchHiveData({required String fieldName, var defaultValue}) async {
  //   if (await Hive.boxExists('araBox') && Hive.isBoxOpen('araBox')) {
  //     var data = dbBox.value!.get(fieldName) ?? defaultValue;
  //     // log("Data retrieved from Hive Hive with following structure \n {$fieldName : $data}");
  //     return data;
  //   }
  // }

  // Future<void> setHiveData({required String fieldName, var data}) async {
  //   await dbBox.value?.put(fieldName, data);
  // }
}

GeneralConfigController generalConfigController = GeneralConfigController();
