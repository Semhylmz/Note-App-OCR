import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/color_constants.dart';
import '../../../notifier/theme_notifier.dart';
import '../../detail_view/detail_view.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.linear,
      duration: const Duration(milliseconds: 300),
      child: Container(
        key: UniqueKey(),
        decoration: BoxDecoration(
          border: Border.all(color: mRed, width: 3.0),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: Icon(Icons.edit_outlined,
                color: context.watch<ThemeNotifier>().isLight
                    ? mBlackOpacityColor
                    : mWhiteOpacityColor),
          ),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetailView(
                  text: '',
                  title: '',
                  id: '',
                  category: '',
                  isFirst: true,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
