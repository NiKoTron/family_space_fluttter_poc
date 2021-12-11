import 'package:family_space_flutter/model/user.dart';

abstract class ParticipantsRepository {
  Future<List<User>> getParticipants();
}
