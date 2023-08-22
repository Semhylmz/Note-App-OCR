// import 'package:flutter/material.dart';
// import 'package:noteapp/notifier/recorder_notifier.dart';
// import '../../../constants/color_constants.dart';
// import '../../../notifier/theme_notifier.dart';
//
// Future<dynamic> recorderShowModalBottomSheet(
//     BuildContext context, RecorderNotifier recorder, ThemeNotifier theme) {
//   return showModalBottomSheet(
//     context: context,
//     backgroundColor: theme.isLight ? mWhiteColor : mBlackColor,
//     useSafeArea: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(24.0),
//         topRight: Radius.circular(24.0),
//       ),
//     ),
//     builder: (BuildContext context) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Kayıt ismi ekleyebilirsiniz',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
//                 ),
//                 IconButton(
//                     onPressed: () {
//                       recorder.setIsRecordCompleted = false;
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(
//                       Icons.save_outlined,
//                       size: 32.0,
//                       color: theme.isLight ? mBlackColor : mWhiteColor,
//                     )),
//               ],
//             ),
//           ),
//           TextField(
//             controller: recorder.titleEditingController,
//             textCapitalization: TextCapitalization.sentences,
//             autofocus: true,
//             maxLines: null,
//             textInputAction: TextInputAction.done,
//             onChanged: (newValue) {
//               recorder.setRecordName = newValue;
//             },
//             style: TextStyle(
//                 fontSize: 18.0,
//                 color: theme.isLight == true
//                     ? mBlackOpacityColor
//                     : mWhiteOpacityColor),
//             decoration: const InputDecoration(
//               hintText: 'Kayıt ismi',
//               border: InputBorder.none,
//               hintStyle: TextStyle(
//                   fontSize: 18.0,
//                   color: Colors.grey,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
