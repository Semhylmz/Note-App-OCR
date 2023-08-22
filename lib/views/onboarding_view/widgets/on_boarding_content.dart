import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/on_board_list.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    super.key,
    required this.idx,
  });

  final int idx;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        LottieBuilder.asset(onboardList[idx].path, height: 250),
        const Spacer(),
        Text(
          onboardList[idx].title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: mBlackColor,
              ),
        ),
        const SizedBox(height: 16.0),
        Text(
          onboardList[idx].desc,
          textAlign: TextAlign.center,
          style: const TextStyle(color: mBlackColor),
        ),
        const Spacer(),
      ],
    );
  }
}
