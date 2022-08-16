class SpendRecords {
  String? category;
  int? spend;
  String? date; // should be Datetime
  DateTime? created;
  String? note;

  SpendRecords();

  Map<String, dynamic> toJson() => {
    'Category': category,
    'Spend': spend,
    'Date': date,
    'Created Date': created,
    'Notes': note
  };

  SpendRecords.fromSnapshot(snapshot)
      : category = snapshot.data()['Category'],
        spend = snapshot.data()['Spend'],
        date = snapshot.data()['Date'],
        created = snapshot.data()['Created Date'].toDate(),
        note = snapshot.data()['Notes'];
}