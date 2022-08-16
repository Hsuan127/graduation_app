class VaccineRecords {
  String? vacName;
  String? date; // should be Datetime
  DateTime? created;
  String? note;

  VaccineRecords();

  Map<String, dynamic> toJson() => {
    'Vaccine Name': vacName,
    'Date': date,
    'Created Date': created,
    'Notes': note
  };

  VaccineRecords.fromSnapshot(snapshot)
      : vacName = snapshot.data()['Vaccine Name'],
        date = snapshot.data()['Date'],
        created = snapshot.data()['Created Date'].toDate(),
        note = snapshot.data()['Notes'];
}
