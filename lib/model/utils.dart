import 'package:cloud_firestore/cloud_firestore.dart';

DateTime? convertStringToDate(String datetime) {
  try {
    return DateTime.parse(datetime);
  } catch(e) {
    print(e);
  }
  return null;
}

DateTime? timestampToDateTime(Timestamp timestamp) {
  return timestamp.toDate();
}