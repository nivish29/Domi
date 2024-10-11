part of 'bottom_sheet_bloc.dart';

@immutable
sealed class BottomSheetState {}

final class BottomSheetInitial extends BottomSheetState {}
final class BottomSheetLoaded extends BottomSheetState {
  List<Document> filteredDocuments;
  BottomSheetLoaded(this.filteredDocuments);
}

class BottomSheetVisible extends BottomSheetState {
  final List<Document> filteredDocuments;
  BottomSheetVisible(this.filteredDocuments);
}
final class BottomSheetHidden extends BottomSheetState {}