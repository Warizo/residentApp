class Payment {
  String? dueType;
  String? payAmount;
  PayDate? payDate;
  String? residentID;
  String? payMode;
  String? iD;
  PayDate? createdAt;

  Payment({
    this.dueType,
    this.payAmount,
    this.payDate,
    this.residentID,
    this.payMode,
    this.iD,
    this.createdAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      dueType: json['DueType'],
      payAmount: json['PayAmount'],
      payDate: json['PayDate'] != null
          ? new PayDate.fromJson(json['PayDate'])
          : null,
      residentID: json['ResidentID'],
      payMode: json['PayMode'],
      iD: json['ID'],
      createdAt: json['CreatedAt'] != null
          ? new PayDate.fromJson(json['CreatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DueType'] = this.dueType;
    data['PayAmount'] = this.payAmount;
    if (this.payDate != null) {
      data['PayDate'] = this.payDate!.toJson();
    }
    data['ResidentID'] = this.residentID;
    data['PayMode'] = this.payMode;
    data['ID'] = this.iD;
    if (this.createdAt != null) {
      data['CreatedAt'] = this.createdAt!.toJson();
    }
    return data;
  }
}

class PayDate {
  String? date;
  int? timezoneType;
  String? timezone;

  PayDate({this.date, this.timezoneType, this.timezone});

  factory PayDate.fromJson(Map<String, dynamic> json) {
    return PayDate(
      date: json['date'],
      timezoneType: json['timezone_type'],
      timezone: json['timezone'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['timezone_type'] = this.timezoneType;
    data['timezone'] = this.timezone;
    return data;
  }
}
