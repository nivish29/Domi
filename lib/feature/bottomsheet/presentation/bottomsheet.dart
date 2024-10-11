import 'package:domi_assignment/feature/app_apearance/presentation/bloc/app_appearance_bloc.dart';
import 'package:domi_assignment/feature/bottomsheet/data/model/document.dart';
import 'package:domi_assignment/feature/bottomsheet/presentation/bloc/bottom_sheet_bloc.dart';
import 'package:domi_assignment/theme/app_pallete.dart';
import 'package:domi_assignment/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

DraggableScrollableController bottomSheetController =
    DraggableScrollableController();

Widget buildDraggableBottomSheet(BuildContext context) {
  return BlocBuilder<BottomSheetBloc, BottomSheetState>(
    builder: (context, state) {
      if (state is BottomSheetVisible) {
        return DraggableScrollableSheet(
          initialChildSize: 0.3,
          minChildSize: 0.0,
          maxChildSize: 1.0,
          snap: true,
          snapSizes: const [0.0, 0.15, 0.7, 1.0],
          controller: bottomSheetController,
          builder: (BuildContext context, ScrollController scrollController) {
            return BlocBuilder<AppAppearanceBloc, AppAppearanceState>(
              builder: (context, appAppearanceState) {
                bool isLightTheme =
                    appAppearanceState is AppAppearanceUpdated &&
                        appAppearanceState.selectedTheme == 'Light';

                final theme =
                    isLightTheme ? AppThemes.lightTheme : AppThemes.darkTheme;
                return Container(
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: AppPallete.greyColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: theme.brightness == Brightness.light
                                  ? AppPallete.greyShade100.withOpacity(0.6)
                                  : AppPallete.cardBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'dōmi in',
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: theme.textTheme.bodyLarge?.color,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 110,
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    bottom: 15,
                                    top: 10,
                                    right: 15,
                                  ),
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    children: [
                                      _buildImageCard(
                                          'assets/images/image1.jpg'),
                                      _buildImageCard(
                                          'assets/images/image2.jpg'),
                                      _buildImageCard(
                                          'assets/images/image3.jpg'),
                                      _buildImageCard(
                                          'assets/images/image4.jpg'),
                                      _buildImageCard(
                                          'assets/images/image3.jpg'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.brightness == Brightness.light
                                  ? AppPallete.greyShade100.withOpacity(0.6)
                                  : AppPallete.cardBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 10, right: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'dōmi docs',
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: theme.textTheme.bodyLarge?.color,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: TextField(
                                    style: TextStyle(
                                        color: theme.textTheme.bodyLarge?.color
                                            ?.withOpacity(0.7)),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: isLightTheme
                                          ? AppPallete.greyShade200
                                          : AppPallete.inputBackgroundColor,
                                      hintText: 'Search docs',
                                      hintStyle: TextStyle(
                                        color: theme.textTheme.bodyLarge?.color
                                            ?.withOpacity(0.5),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      context
                                          .read<BottomSheetBloc>()
                                          .add(SearchDocuments(value));
                                    },
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.filteredDocuments.length,
                                  itemBuilder: (context, index) {
                                    return _buildDocumentTile(
                                        state.filteredDocuments[index].title,
                                        state.filteredDocuments[index].date,
                                        theme);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      }
      return Container();
    },
  );
}

Widget _buildImageCard(String imagePath) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imagePath,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget _buildDocumentTile(String title, String date, ThemeData theme) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? AppPallete.greyShade200
            : AppPallete
                .darkCardBackgroundColor, 
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
        child: Row(
          children: [
            const Icon(Icons.picture_as_pdf, color: AppPallete.pdfIconColor, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    'Opened $date',
                    style: TextStyle(
                      color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
