class ServerModel {
  final String smtpEmail;
  final String smtpPass;

  ServerModel({
    required this.smtpEmail,
    required this.smtpPass,
  });
  factory ServerModel.fromMap(Map<String, dynamic> map) {
    return ServerModel(
      smtpEmail: map['smtpEmail'],
      smtpPass: map['smtpPass'],
    );
  }
}
