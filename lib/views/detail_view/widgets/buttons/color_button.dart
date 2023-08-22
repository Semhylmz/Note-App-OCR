import 'package:flutter/material.dart';
import 'package:noteapp/notifier/note_color_notifier.dart';
import 'package:provider/provider.dart';
import '../../../../constants/color_list.dart';
import '../../../../constants/color_constants.dart';

IconButton colorButton(BuildContext context, bool isLight, String color) {
  return IconButton(
    onPressed: () {
      showModalBottomSheet(
          context: context,
          backgroundColor: isLight ? mWhiteColor : mBlackColor,
          useSafeArea: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          builder: (BuildContext bc) {
            return Consumer<NoteColorNotifier>(
              builder: (context, value, child) => SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: value.colorSize,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, idx) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () => value.chooseColor(idx),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: colorList[idx],
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: isLight
                                      ? mBlackColor.withOpacity(0.5)
                                      : mWhiteColor.withOpacity(0.5))),
                          child: value.selectedColor ==
                                  colorList[idx].value.toString()
                              ? Icon(
                                  Icons.check_outlined,
                                  color: value.selectedColor ==
                                          mWhiteColor.value.toString()
                                      ? Colors.black
                                      : Colors.white,
                                )
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          });
    },
    icon: Icon(
      Icons.color_lens_outlined,
      color: isLight ? mBlackOpacityColor : mWhiteOpacityColor,
      size: 22.0,
    ),
  );
}
