import 'package:flutter/material.dart';
import 'package:noteapp/extension/get_date_now.dart';
import 'package:noteapp/notifier/note_text_controller_notifier.dart';
import 'package:noteapp/notifier/note_color_notifier.dart';
import 'package:noteapp/notifier/note_notifier.dart';
import 'package:noteapp/views/detail_view/widgets/detail_appbar.dart';
import 'package:noteapp/views/detail_view/widgets/detail_save_dialog.dart';
import 'package:provider/provider.dart';
import '../../extension/show_date.dart';
import '../../model/note_db_model.dart';
import '../../notifier/theme_notifier.dart';
import '../home_view/home_view.dart';
import 'widgets/detail_body.dart';
import 'package:intl/date_symbol_data_local.dart';

class DetailView extends StatefulWidget {
  const DetailView({
    Key? key,
    required this.text,
    required this.title,
    required this.id,
    required this.category,
    required this.isFirst,
    this.idx,
    this.value,
  }) : super(key: key);

  final String id;
  final String title;
  final String category;
  final String text;
  final bool isFirst;
  final int? idx;
  final NoteNotifier? value;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late String date;

  @override
  void initState() {
    initControllers();
    initializeDateFormatting();
    super.initState();
  }

  void disposeController() {
    Provider.of<NoteTextControllerNotifier>(context, listen: false)
        .controllerDispose();
  }

  Future<void> initControllers() async {
    await Provider.of<NoteTextControllerNotifier>(context, listen: false)
        .initControllers(widget.isFirst ? '' : widget.title,
            widget.isFirst ? '' : widget.category, widget.text)
        .then(
          (_) =>
              Provider.of<NoteColorNotifier>(context, listen: false).initColor(
            colorVal: widget.isFirst
                ? Colors.transparent.value.toString()
                : widget.value!.list[widget.idx!].color,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = Provider.of<ThemeNotifier>(context, listen: false).isLight;

    String dateTemp = widget.isFirst
        ? context.dateNow
        : Provider.of<NoteNotifier>(context, listen: false)
            .list[widget.idx!]
            .date;

    String date =
        showDate(dateTemp: dateTemp, context: context, isFirst: widget.isFirst);

    String selectedColor = context.watch<NoteColorNotifier>().selectedColor;
    NoteTextControllerNotifier noteTextControllerNotifier =
        Provider.of<NoteTextControllerNotifier>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        noteTextControllerNotifier.textEditingController.text.isEmpty &&
                noteTextControllerNotifier
                    .titleEditingController.text.isEmpty &&
                noteTextControllerNotifier
                    .categoryEditingController.text.isEmpty
            ? saveDialog(
                    context,
                    NoteDbModel(
                        title: '',
                        content: '',
                        category: '',
                        date: date,
                        color: selectedColor),
                    isLight,
                    widget.isFirst,
                    widget.isFirst ? null : int.parse(widget.id))
                .then(
                (_) => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HomePage(),
                  ),
                ),
              )
            : await Provider.of<NoteNotifier>(context, listen: false)
                .addUpdate(
                    NoteDbModel(
                        title: noteTextControllerNotifier
                            .titleEditingController.value.text,
                        content: noteTextControllerNotifier
                            .textEditingController.value.text,
                        category: noteTextControllerNotifier
                            .categoryEditingController.value.text,
                        date: context.dateNow,
                        color: selectedColor),
                    widget.isFirst,
                    widget.isFirst ? null : int.parse(widget.id))
                .then(
                  (_) => Provider.of<NoteColorNotifier>(context, listen: false)
                      .defaultColor()
                      .then(
                        (_) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomePage(),
                          ),
                          (route) => true,
                        ),
                      ),
                );
        return false;
      },
      child: Consumer3<NoteTextControllerNotifier, NoteColorNotifier,
          NoteNotifier>(builder: (context, value, colorValue, note, child) {
        return Scaffold(
          appBar: detailAppbar(context, isLight, colorValue.selectedColor,
              widget.id, widget.isFirst, dateTemp, value),
          body: DetailBody(
            value: value,
            noteNotifier: note,
            isLight: isLight,
            color: colorValue.selectedColor,
            date: date,
          ),
        );
      }),
    );
  }
}
