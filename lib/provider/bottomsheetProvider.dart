import 'package:domi_assignment/model/document.dart';
import 'package:flutter/material.dart';
import 'dart:async'; 

class BottomSheetProvider with ChangeNotifier {
  bool _isBottomSheetVisible = true; 
  List<Document> documents = [
    Document('100 Martinique Ave Title', 'Dec 4, 2023'),
    Document('Chase Bank Statement - November 2023', 'Dec 3, 2023'),
    Document('Backyard Remodel Renderings', 'Nov 30, 2023'),
    Document('Chase Bank Statement - November 2023', 'Dec 3, 2023'),
    Document('100 Martinique Ave Title', 'Dec 4, 2023'),
    Document('Chase Bank Statement - November 2023', 'Dec 3, 2023'),
    Document('Backyard Remodel Renderings', 'Nov 30, 2023'),
    Document('Chase Bank Statement - November 2023', 'Dec 3, 2023'),
    Document('100 Martinique Ave Title', 'Dec 4, 2023'),
    Document('Chase Bank Statement - November 2023', 'Dec 3, 2023'),
    Document('Backyard Remodel Renderings', 'Nov 30, 2023'),
    Document('Chase Bank Statement - November 2023', 'Dec 3, 2023'),
  ];
  
  late List<Document> filteredDocuments; 
    late Timer _debounce = Timer(const Duration(seconds: 0), () {}); // Initialize _debounce


  BottomSheetProvider() {
    filteredDocuments = List.from(documents);
  }

  bool get isBottomSheetVisible => _isBottomSheetVisible;

  void hideBottomSheet() {
    _isBottomSheetVisible = false;
    notifyListeners();
  }

  void showBottomSheet() {
    _isBottomSheetVisible = true;
    notifyListeners();
  }
  void searchDocuments(String query) {
    if (_debounce.isActive) {
      _debounce.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.isEmpty) {
        filteredDocuments = List.from(documents);
      } else {
        filteredDocuments = documents
            .where((doc) => doc.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      notifyListeners(); 
    });
  }
}
