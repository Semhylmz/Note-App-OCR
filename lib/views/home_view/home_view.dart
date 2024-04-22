import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:noteapp/constants/color_constants.dart';
import 'package:noteapp/notifier/note_notifier.dart';
import 'package:noteapp/notifier/note_view_notifier.dart';
import 'package:noteapp/notifier/recorder_notifier.dart';
import 'package:noteapp/notifier/theme_notifier.dart';
import 'package:noteapp/views/home_view/home_voice_content.dart';
import 'package:noteapp/views/home_view/widgets/custom_bottom_app_bar.dart';
import 'package:noteapp/views/home_view/widgets/custom_floating_action_bar.dart';
import 'package:noteapp/views/home_view/widgets/home_appbar.dart';
import 'package:noteapp/views/home_view/home_note_content.dart';
import 'package:noteapp/views/home_view/widgets/home_drawer.dart';
import 'package:noteapp/views/home_view/widgets/home_empty_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Consumer3<NoteNotifier, RecorderNotifier, NoteViewNotifier>(
        builder: (context, notes, recorder, crossAxisCount, child) => Scaffold(
          key: UniqueKey(),
          appBar: homeAppbar(context.watch<ThemeNotifier>().isLight, context,
              _tabController, notes),
          drawer: const HomeDrawer(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: const CustomFloatingActionButton(),
          bottomNavigationBar: const CustomBottomAppBar(),
          body: TabBarView(
            controller: _tabController,
            children: [
              /// Notes page
              notes.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: mRed, strokeWidth: 3.0))
                  : notes.list.isEmpty
                      ? EmptyWidget(
                          isLight: context.watch<ThemeNotifier>().isLight,
                          text: 'Henüz not eklemediniz')
                      : Center(
                          child: StaggeredGridView.countBuilder(
                            crossAxisCount: crossAxisCount.crossAxisCount,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                            itemCount: notes.list.length,
                            itemBuilder: (context, idx) => homeContent(
                                value: notes, context: context, idx: idx),
                            staggeredTileBuilder: (int idx) =>
                                const StaggeredTile.fit(1),
                          ),
                        ),

              /// Voice notes page
              recorder.isLoading
                  ? const CircularProgressIndicator(color: mBlue)
                  : homeVoicePage(recorder: recorder, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
