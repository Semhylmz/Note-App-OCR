import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../../constants/color_constants.dart';
import '../../../../notifier/theme_notifier.dart';
import '../../../../service/local_auth_service.dart';
import 'drawer_list_tile.dart';

class BiometricListTile extends StatelessWidget {
  const BiometricListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await LocalAuthService.isSupported()
            ? await LocalAuthService.hasBiometrics()
                ? showDialog(
                    context: context,
                    builder: (context) => Consumer<LocalAuthService>(
                      builder: (context, value, child) => AlertDialog(
                        backgroundColor: context.watch<ThemeNotifier>().isLight
                            ? mWhiteColor
                            : mBlackColor,
                        title: const Text('Biyometrik Doğrulama'),
                        content: Text(
                          value.isPassword
                              ? 'Biyometrik doğrulama devre dışı bırakılacak.'
                              : 'Cihazınızda kayıtlı biyometrik doğrulama yöntemini kullanarak notlarınıza erişebileceksiniz.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              value.isPassword
                                  ? value.setIsPassword(value: false).then(
                                        (_) => Fluttertoast.showToast(
                                          msg:
                                              'Kimlik doğrulama devre dışı bırakıldı',
                                          toastLength: Toast.LENGTH_LONG,
                                          backgroundColor: mRed,
                                        ),
                                      )
                                  : value.setIsPassword(value: true).then(
                                        (_) => Fluttertoast.showToast(
                                          msg:
                                              'Kimlik doğrulama aktifleştirildi',
                                          toastLength: Toast.LENGTH_LONG,
                                          backgroundColor: mRed,
                                        ),
                                      );
                            },
                            child: Text(
                              value.isPassword
                                  ? 'Devre dışı bırak'
                                  : 'Etkinleştir',
                              style: const TextStyle(
                                color: mBlue,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Vazgeç',
                              style: TextStyle(
                                color: mBlue,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Fluttertoast.showToast(
                    msg: 'Lütfen ayarlardan parmak izi ekleyin',
                    toastLength: Toast.LENGTH_LONG,
                    backgroundColor: mRed,
                  )
            : Fluttertoast.showToast(
                msg: 'Cihazınız biyometrik doğrulamayı desteklemiyor',
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: mRed,
              );
      },
      child: DrawerListTile(
        title: 'Uygulama kilidi',
        icon: context.watch<LocalAuthService>().isPassword
            ? Icons.lock_outlined
            : Icons.lock_open_outlined,
      ),
    );
  }
}
