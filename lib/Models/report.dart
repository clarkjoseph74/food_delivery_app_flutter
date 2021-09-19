import 'dart:convert';

class Report {
  final String name;
  final String email;
  final String message;
  Report({
    required this.name,
    required this.email,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'message': message,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      name: map['name'],
      email: map['email'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) => Report.fromMap(json.decode(source));
}
