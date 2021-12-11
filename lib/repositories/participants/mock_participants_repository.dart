import 'package:family_space_flutter/model/user.dart';
import 'package:family_space_flutter/repositories/participants/participants_repository.dart';

import 'dart:math';

class MockParticipantsRepository implements ParticipantsRepository {
  @override
  Future<List<User>> getParticipants() async => [
        'Мать',
        'Папа',
        'Сын',
      ].map(_userMap).toList();

  User _userMap(String name) => User(
        avatarUrl: 'https://i.pravatar.cc/300?img=${Random().nextInt(70)}',
        name: name,
        joinedSince: DateTime.now().subtract(
          Duration(hours: Random().nextInt(23), minutes: Random().nextInt(59)),
        ),
        batteryStatus: Random().nextBool(),
      );
}
