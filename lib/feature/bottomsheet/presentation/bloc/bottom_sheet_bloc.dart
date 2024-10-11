import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:domi_assignment/feature/bottomsheet/data/model/document.dart';
import 'package:meta/meta.dart';

part 'bottom_sheet_event.dart';
part 'bottom_sheet_state.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  final List<Document> _documents = [
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

  late List<Document> _filteredDocuments;

  BottomSheetBloc() : super(BottomSheetInitial()) {
    _filteredDocuments = List.from(_documents);
    emit(BottomSheetVisible(_filteredDocuments));

    on<ShowBottomSheet>(_onShowBottomSheet);
    on<HideBottomSheet>(_onHideBottomSheet);
    on<SearchDocuments>(_onSearchDocuments);

    add(SearchDocuments(''));
  }

  void _onShowBottomSheet(
      ShowBottomSheet event, Emitter<BottomSheetState> emit) {
    emit(BottomSheetVisible(_documents));
  }

  void _onHideBottomSheet(
      HideBottomSheet event, Emitter<BottomSheetState> emit) {
    emit(BottomSheetHidden());
  }

  Future<void> _onSearchDocuments(
      SearchDocuments event, Emitter<BottomSheetState> emit) async {
    try {
      final filteredDocuments = await _filterDocumentsAsync(event.query);
      print("Filtered Documents Count: ${filteredDocuments.length}");
      emit(BottomSheetVisible(filteredDocuments));
    } catch (e) {
      print("Error in filtering documents: $e");
    }
  }

  Future<List<Document>> _filterDocumentsAsync(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (query.isEmpty) {
      return List.from(_documents);
    } else {
      return _documents
          .where((doc) => doc.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
