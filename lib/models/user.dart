import '../string_util.dart';

enum LoginType { email, phone }

class User with UserUtils {
  String email;
  String phone;

  List<User> friends = [];

  LoginType _type;
  String _lastName;
  String _firstName;

  User._({
    String firstName,
    String lastName,
    String email,
    String login,
    Map<String, Object> meta,
    List<User> friends,
    String phone,
  })  : this._firstName = firstName,
        this._lastName = lastName,
        this.email = email,
        this.phone = phone {
    _type = email != null ? LoginType.email : LoginType.phone;
  }

  User.withPhone(String userName, String phone) {
    _type = LoginType.phone;
    this.phone = checkPhone(phone);
    _lastName = _getLastName(userName);
    _firstName = _getFirstName(userName);
  }

  User.withEmail(String userName, String email) {
    _type = LoginType.email;
    this.email = checkEmail(email);
    _lastName = _getLastName(userName);
    _firstName = _getFirstName(userName);
  }

  factory User({String name, String phone, String email}) {
    if (name.isEmpty && (phone.isEmpty || email.isEmpty)) throw Exception('User name is not valid');
  
    return User._(
      lastName: _getLastName(name),
      firstName: _getFirstName(name),
      email: email != null ? checkEmail(email) : null,
      phone: phone != null ? checkPhone(phone) : null,
    );
  }

  static String _getLastName(String userName) => userName.split(' ')[1];
  static String _getFirstName(String userName) => userName.split(' ')[0];

  String get login {
    if (_type == LoginType.email) {
      return email;
    } else {
      return phone;
    }
  }

  String get userInfo => '''
    name: $name
    email: $email
    firstName: $_firstName
    lastName: $_lastName
    phone: $phone
    friends: ${friends.toList()}
  ''';

  String get name => '${_firstName.cappitalize()} ${capitalize(_lastName)}';

  static String checkPhone(String phone) {
    String pattern = r'^(?:[+0])?[0-9]{11}$';
    phone = phone.replaceAll(RegExp("[^+\\d]"), ""); // Удаляем всё кроме чисел и `+`

    if (phone == null || phone.isEmpty) {
      throw Exception('Enter don\'t empty phone number');
    } else if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception('Enter a valid phone number starting with a + and containing 11 digits');
    }

    return phone;
  }

  static String checkEmail(String email) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

    if (email == null || email.isEmpty) {
      throw Exception('Enter don\'t empty email number');
    } else if (!emailValid) {
      throw Exception('Email is not valid');
    }

    return email;
  }

  void addFriends(Iterable<User> newFriends) {
    friends.addAll(newFriends);
  }

  void removeFriend(User user) {
    friends.remove(user);
  }

  @override
  bool operator ==(Object other) {
    if (other == null) {
      return false;
    }

    if (other is User) {
      return _firstName == other._firstName &&
          _lastName == other._lastName &&
          (email == other.email || phone == other.phone);
    }

    return false;
  }
}
