import 'package:get_it/get_it.dart';
import 'package:domi_assignment/feature/app_apearance/presentation/bloc/app_appearance_bloc.dart';
import 'package:domi_assignment/feature/bottomsheet/presentation/bloc/bottom_sheet_bloc.dart';
import 'package:domi_assignment/feature/map_screen/data/datasource/map_remote_data_source.dart';
import 'package:domi_assignment/feature/map_screen/data/repository/map_repository_impl.dart';
import 'package:domi_assignment/feature/map_screen/domain/usecase/get_building_outline.dart';
import 'package:domi_assignment/feature/map_screen/domain/usecase/get_nearest_place.dart';
import 'package:domi_assignment/feature/map_screen/domain/usecase/process_osm_data.dart';
import 'package:domi_assignment/feature/map_screen/presentation/bloc/map_bloc.dart';

final GetIt getIt = GetIt.instance;

void initDependencies() {
  // Register Data Source
  getIt.registerLazySingleton<MapRemoteDataSource>(() => MapRemoteDataSource());

  // Register Repository
  getIt.registerLazySingleton<MapRepositoryImpl>(() => MapRepositoryImpl(getIt<MapRemoteDataSource>()));

  // Register Use Cases
  getIt.registerLazySingleton<GetBuildingOutline>(() => GetBuildingOutline(getIt<MapRepositoryImpl>()));
  getIt.registerLazySingleton<GetNearestPlace>(() => GetNearestPlace(getIt<MapRepositoryImpl>()));
  getIt.registerLazySingleton<ProcessOsmData>(() => ProcessOsmData());

  // Register BLoCs
  getIt.registerFactory(() => AppAppearanceBloc());
  getIt.registerFactory(() => BottomSheetBloc());
  getIt.registerFactory(() => MapBloc(
        appAppearanceBloc: getIt<AppAppearanceBloc>(),
        getNearestPlace: getIt<GetNearestPlace>(),
        getBuildingOutline: getIt<GetBuildingOutline>(),
        processOsmData: getIt<ProcessOsmData>(),
      ));
}
