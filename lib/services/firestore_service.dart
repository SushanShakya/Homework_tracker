import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:progress_tracker/data/constants.dart';
import 'package:progress_tracker/models/last_updated.dart';
import 'package:progress_tracker/models/subject_status.dart';

class FirestoreService {
  /// Creates this Class as a Singleton

  static FirestoreService _service;

  factory FirestoreService() {
    if (_service == null) {
      _service = FirestoreService._instance();
    }

    return _service;
  }

  FirestoreService._instance();

  /// Instance for the Firestore Database

  Firestore _db = Firestore.instance;

  Stream<List<Subject>> getSubjects() {
    return _db.collection(SUBJECTSCOLLECTION).snapshots().map((snapshot) =>
        snapshot.documents
            .map((doc) => Subject.fromJson(doc.data, doc.documentID))
            .toList());
  }

  Future<List<Subject>> getCurrentSubjects() async {
    var snapshot = await _db.collection(SUBJECTSCOLLECTION).getDocuments();
    return snapshot.documents
        .map((doc) => Subject.fromJson(doc.data, doc.documentID))
        .toList();
  }

  Future<LastUpdated> getLastUpdatedDate() async {
    DocumentSnapshot doc = await _db
        .collection(LASTUPDATEDCOLECTION)
        .document(LASTUPDATEDDOCUMENT)
        .get();
    return LastUpdated.fromJson(doc.data, doc.documentID);
  }

  Future<void> addNewSubject(Subject subject) {
    return _db.collection(SUBJECTSCOLLECTION).add(subject.toMap());
  }

  Future<void> updateSubjectStatus(Subject subject) {
    return _db
        .collection(SUBJECTSCOLLECTION)
        .document(subject.id)
        .updateData(subject.toMap());
  }

  Future<void> updateLastUpdated() {
    return _db
        .collection(LASTUPDATEDCOLECTION)
        .document(LASTUPDATEDDOCUMENT)
        .updateData(LastUpdated(
                lastUpdated: DateFormat('yyyy-MM-dd').format(DateTime.now()))
            .toJson());
  }

  Future<void> addNewdevice(String token) {
    return _db.collection(DEVICETOKENCOLLECTION).add({"token": token});
  }

  Future<List<String>> getDevicesList() async{
    List<String> _devices = [];

    var doc = await _db.collection(DEVICETOKENCOLLECTION).getDocuments();

    for (int i = 0; i< doc.documents.length; i++){
      _devices.add(doc.documents[i].data['token']);
    }
    return _devices;
  }
}
