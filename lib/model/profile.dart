class Profile {
  String? id;
  String? email;
  String? username;
  int balance;
  String? password;
  String? fullname;
  String? telNum;

  Profile({
    this.id,
    this.email,
    this.username,
    required this.balance,
    this.password,
    this.fullname,
    this.telNum
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'balance': balance,
      'password': password,
      'fullname': fullname,
      'telNum': telNum
    };
  }
}