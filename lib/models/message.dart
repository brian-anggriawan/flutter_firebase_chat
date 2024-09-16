import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String message;
  final String receiverId;
  final Timestamp timestamp;

  const Message({
    required this.senderId,
    required this.senderEmail,
    required this.message,
    required this.receiverId,
    required this.timestamp,
  });

  Map<String, dynamic> convertToMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'message': message,
      'receiverId': receiverId,
      'timestamp': timestamp,
    };
  }
}
