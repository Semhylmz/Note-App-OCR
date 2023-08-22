import 'package:encrypt/encrypt.dart';
import 'package:noteapp/model/note_db_model.dart';
import 'package:noteapp/service/encrypter_keys_service.dart';

class EncryptNoteService {
  late final KeysService keysService;
  late final String storageKey;
  late final String storageIv;
  late final Encrypter encrypter;
  late final IV encIv;

  Future<void> createEncrypter() async {
    keysService = KeysService();
    storageKey = await keysService.getDbKeys();
    storageIv = await keysService.getDbIv();

    final key = Key.fromUtf8(storageKey);
    encIv = IV.fromUtf8(storageIv);
    encrypter = Encrypter(AES(key));
  }

  Future<NoteDbModel> encryptNote({required NoteDbModel noteDbModel}) async {
    await createEncrypter();

    final encryptedTitle = noteDbModel.title.isEmpty
        ? ''
        : encrypter.encrypt(noteDbModel.title, iv: encIv).base64;
    final encryptedContent = noteDbModel.content.isEmpty
        ? ''
        : encrypter.encrypt(noteDbModel.content, iv: encIv).base64;
    final encryptedCategory = noteDbModel.category.isEmpty
        ? ''
        : encrypter.encrypt(noteDbModel.category, iv: encIv).base64;

    final encryptedDate = encrypter.encrypt(noteDbModel.date, iv: encIv).base64;

    final encryptedColor =
        encrypter.encrypt(noteDbModel.color, iv: encIv).base64;

    return NoteDbModel(
      title: encryptedTitle,
      content: encryptedContent,
      category: encryptedCategory,
      date: encryptedDate,
      color: encryptedColor,
    );
  }

  Future<List<NoteDbModel>> decryptNote(List<NoteDbModel> noteDbModel) async {
    await createEncrypter();

    List<NoteDbModel> decryptList = [];

    for (int i = 0; i < noteDbModel.length; i++) {
      final id = noteDbModel[i].id;
      final decryptedTitle = noteDbModel[i].title.isEmpty
          ? ''
          : encrypter.decrypt64(noteDbModel[i].title, iv: encIv);

      final decryptedContent = noteDbModel[i].content.isEmpty
          ? ''
          : encrypter.decrypt64(noteDbModel[i].content, iv: encIv);

      final decryptedCategory = noteDbModel[i].category.isEmpty
          ? ''
          : encrypter.decrypt64(noteDbModel[i].category, iv: encIv);

      final decryptedDate = encrypter.decrypt64(noteDbModel[i].date, iv: encIv);

      final decryptedColor =
          encrypter.decrypt64(noteDbModel[i].color, iv: encIv);

      decryptList.add(NoteDbModel.withId(
          id: id,
          title: decryptedTitle,
          content: decryptedContent,
          category: decryptedCategory,
          date: decryptedDate,
          color: decryptedColor));
    }

    return decryptList;
  }
}
