import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:noteapp/constants/color_constants.dart';
import 'package:noteapp/model/note_db_model.dart';
import 'package:noteapp/notifier/note_notifier.dart';
import 'package:noteapp/notifier/theme_notifier.dart';
import 'package:noteapp/views/home_view/widgets/home_empty_widget.dart';
import 'package:provider/provider.dart';
import '../home_note_content.dart';

class CustomSearchDelegate extends SearchDelegate {
  NoteNotifier noteNotifier;

  CustomSearchDelegate({required this.noteNotifier});

  @override
  Widget buildResults(BuildContext context) {
    List<NoteDbModel> matchingList = noteNotifier.list
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return query.isNotEmpty & matchingList.isEmpty
        ? EmptyWidget(
            isLight: context.watch<ThemeNotifier>().isLight,
            text: 'Aradığınız Not Bulunamadı')
        : Center(
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              itemCount: matchingList.length,
              itemBuilder: (context, idx) =>
                  homeContent(value: noteNotifier, context: context, idx: idx),
              staggeredTileBuilder: (int idx) => const StaggeredTile.fit(1),
            ),
          );
  }

  @override
  Widget? buildLeading(BuildContext context) => StatefulBuilder(
        builder: (context, setState) => IconButton(
          onPressed: () => close(context, null),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        StatefulBuilder(
          builder: (context, setState) => IconButton(
            onPressed: () {
              query.isEmpty ? close(context, null) : query = '';
            },
            icon: const Icon(Icons.clear_outlined),
          ),
        ),
      ];

  @override
  String get searchFieldLabel => 'Notlarınızda arayın';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      brightness: context.watch<ThemeNotifier>().isLight
          ? Brightness.light
          : Brightness.dark,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: mRed),
      scaffoldBackgroundColor:
          context.watch<ThemeNotifier>().isLight ? mWhiteColor : mBlackColor,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor:
            context.watch<ThemeNotifier>().isLight ? mWhiteColor : mBlackColor,
        actionsIconTheme: IconThemeData(
            color: context.watch<ThemeNotifier>().isLight
                ? mBlackColor
                : mWhiteColor),
        iconTheme: IconThemeData(
            color: context.watch<ThemeNotifier>().isLight
                ? mBlackColor
                : mWhiteColor),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: mRed),
        ),
        border: UnderlineInputBorder(),
        hintStyle: TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
