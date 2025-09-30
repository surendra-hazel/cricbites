import 'package:Cricbites/data/api_service/api_service.dart';
import 'package:Cricbites/features/all_series/data/modal/all_series_list_modal.dart';
import 'package:Cricbites/widgets/common_app_toast.dart';
import 'package:get/get.dart';

class AllSeriesController extends GetxController {
  var isLoading = false.obs;
  final ApiService _apiService = ApiService();

  RxList<SeriesList> items = <SeriesList>[].obs;
  RxList<String> categoryList = <String>[].obs;
  RxInt selectedCategory = 0.obs;

  /// 🔎 Search Query
  RxString searchQuery = "".obs;

  Future<void> fetchSeriesList() async {
    try {
      isLoading.value = true;
      final result = await _apiService.seriesListMethod();
      if (result.status == "ok") {
        items.assignAll(result.response?.items ?? []);

        categoryList.clear();
        categoryList.add("All Series");

        for (var item in items) {
          if (item.category != null &&
              item.category!.isNotEmpty &&
              !categoryList.contains(item.category)) {
            categoryList.add(item.category!);
          }
        }
        selectedCategory.value = 0;
      } else {
        clearAll();
      }
    } catch (e) {
      AppToast.showError("Something went wrong, Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  void changeCategory(int index) {
    if (index < categoryList.length) {
      selectedCategory.value = index;
    }
  }

  void clearAll() {
    items.clear();
    categoryList.clear();
    categoryList.add("All Series");
    selectedCategory.value = 0;
    searchQuery.value = "";
  }

  /// 🟢 Filtered Items (Category + Search)
  List<SeriesList> get filteredItems {
    final query = searchQuery.value.toLowerCase();

    return items.where((item) {
      // Category filter
      if (selectedCategory.value != 0 &&
          item.category != categoryList[selectedCategory.value]) {
        return false;
      }

      // Search filter
      if (query.isNotEmpty &&
          !(item.title?.toLowerCase().contains(query) ?? false)) {
        return false;
      }

      return true;
    }).toList();
  }
}


