import 'dart:math';

import 'package:life_link/models/uid_model/uid_model.dart';
import 'package:life_link/repositories/firestore_repository.dart';

class IdService {
  static Future<String> createID() async {
    final FirestoreRepository firestoreRepository = FirestoreRepository();
    String chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String numbers = "0123456789";
    final random = Random();
    String randString =
        List.generate(13, (index) => chars[random.nextInt(chars.length)])
            .join();
    int v1 = int.parse(
        List.generate(3, (index) => numbers[random.nextInt(numbers.length)])
            .join());
    int v2 = int.parse(
        List.generate(3, (index) => numbers[random.nextInt(numbers.length)])
            .join());
    int resultedInt = v1 * v2 + random.nextInt(23);
    String combinedString = randString + resultedInt.toString();
    List<String> combinedCharList = combinedString.split('');
    combinedCharList.shuffle(random);
    String uid = combinedCharList.join();
    print(uid);
    bool isUIDDuplicate = await firestoreRepository.uidExist(uid);
    if (isUIDDuplicate) {
      IdService.createID();
    } else {
      firestoreRepository.uploadUID(
        UIDModel(uid: uid),
      );
    }
    return uid;
  }
}
