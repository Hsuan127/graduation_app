class HospitalRecords {
  String? hosName;
  String? problem;
  String? date; // should be Datetime
  DateTime? created;
  String? note;

  HospitalRecords();

  Map<String, dynamic> toJson() => {
        'Hospital Name': hosName,
        'Problem': problem,
        'Date': date,
        'Created Date': created,
        'Notes': note
      };

  HospitalRecords.fromSnapshot(snapshot)
      : hosName = snapshot.data()['Hospital Name'],
        problem = snapshot.data()['Problem'],
        date = snapshot.data()['Date'],
        created = snapshot.data()['Created Date'].toDate(),
        note = snapshot.data()['Notes'];
}
