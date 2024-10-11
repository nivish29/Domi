part of 'bottom_sheet_bloc.dart';

@immutable
sealed class BottomSheetEvent {}
class ShowBottomSheet extends BottomSheetEvent {}
class HideBottomSheet extends BottomSheetEvent {}
class SearchDocuments extends BottomSheetEvent {
  final String query;
  SearchDocuments(this.query);
}