import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noteapp/views/splash_view/splash_page.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/on_board_list.dart';

class BuildDotButton extends StatelessWidget {
  const BuildDotButton({
    super.key,
    required int pageIndex,
    required this.controller,
    required this.isCompleted,
  }) : _pageIndex = pageIndex;

  final int _pageIndex;
  final PageController controller;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          onboardList.length,
          (idx) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: idx == _pageIndex ? 12.0 : 4.0,
              width: idx == _pageIndex ? 12.0 : 4.0,
              decoration: BoxDecoration(
                  color: idx == _pageIndex ? mBlue : mBlue.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(12.0))),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          height: 60.0,
          width: 60.0,
          child: ElevatedButton(
            onPressed: () {
              _pageIndex == onboardList.length - 1
                  ? isCompleted
                      ? Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const SplashPage()),
                          (route) => false)
                      : Fluttertoast.showToast(
                          msg: 'Lütfen bir kaç saniye sonra tekrar dene',
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: mRed)
                  : controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: mBlue, shape: const CircleBorder()),
            child: const Icon(Icons.arrow_forward_outlined),
          ),
        ),
      ],
    );
  }
}
