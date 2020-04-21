import 'package:flutter_test/flutter_test.dart' show Skip, expect, group, isA, setUp, tearDownAll, test, throwsA;

import '../lib/user_holder.dart';
import '../lib/models/user.dart';

void main() {
  UserHolder holder;

  setUp(() {
    holder = UserHolder();
  });

  tearDownAll(() {
    holder = null;
  });

  test('module5', () {
    User user = User(name: "Dan Tot", phone: "+1 (231) 076-1449", email: "dan.tot@yandex.ru");

    List<User> users = holder.importUsers([
      """
      ${user.name};
      ${user.email};
      ${user.phone};
      """,
    ]);

    expect(users[0].login, user.login);
    expect(users[0].email, user.email);
    expect(users[0].phone, user.phone);
  });
}
