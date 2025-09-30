import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  final topSearches = <String>[
    "Top 5 All-Time Greatest ODI Batsmen By ICC Rankings",
    "Top 10 Test Bowlers of All Time",
    "Most Sixes in ODI Cricket",
    "Best T20 Finishers of All Time",
  ].obs;

  List<String> search(String query) {
    if (query.isEmpty) return topSearches;
    return topSearches
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
