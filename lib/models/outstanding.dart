class Outstanding {
  String? dueType;
  String? billAmount;
  BillDate? billDate;
  String? residentID;
  int? id;
  bool? isChecked;

  Outstanding({
    this.dueType,
    this.billAmount,
    this.billDate,
    this.residentID,
    this.id,
    this.isChecked,
  });

  factory Outstanding.fromJson(Map<String, dynamic> json) {
    return Outstanding(
      dueType: json['DueType'],
      billAmount: json['BillAmount'],
      billDate:
          json['BillDate'] != null ? BillDate.fromJson(json['BillDate']) : null,
      residentID: json['ResidentID'],
      id: json['id'],
      isChecked: json['isChecked'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['DueType'] = dueType;
    data['BillAmount'] = billAmount;
    if (billDate != null) {
      data['BillDate'] = billDate!.toJson();
    }
    data['ResidentID'] = residentID;
    data['ID'] = id;
    data['isChecked'] = isChecked;
    return data;
  }
}

class BillDate {
  String? date;
  int? timezoneType;
  String? timezone;

  BillDate({this.date, this.timezoneType, this.timezone});

  factory BillDate.fromJson(Map<String, dynamic> json) {
    return BillDate(
      date: json['date'],
      timezoneType: json['timezone_type'],
      timezone: json['timezone'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = date;
    data['timezone_type'] = timezoneType;
    data['timezone'] = timezone;
    return data;
  }
}
