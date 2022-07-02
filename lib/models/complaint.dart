class Complaint {
  int? iD;
  String? ticketNo;
  String? status;
  ComDate? comDate;
  String? residentID;
  String? subject;
  String? complaint;

  Complaint({
    this.iD,
    this.ticketNo,
    this.status,
    this.comDate,
    this.residentID,
    this.subject,
    this.complaint,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      iD: json['ID'],
      ticketNo: json['TicketNo'],
      status: json['Status'],
      comDate: json['ComDate'] != null
          ? new ComDate.fromJson(json['ComDate'])
          : null,
      residentID: json['ResidentID'],
      subject: json['Subject'],
      complaint: json['Complaint'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['TicketNo'] = this.ticketNo;
    data['Status'] = this.status;
    if (this.comDate != null) {
      data['ComDate'] = this.comDate!.toJson();
    }
    data['ResidentID'] = this.residentID;
    data['Subject'] = this.subject;
    data['Complaint'] = this.complaint;
    return data;
  }
}

class ComDate {
  String? date;
  int? timezoneType;
  String? timezone;

  ComDate({this.date, this.timezoneType, this.timezone});

  factory ComDate.fromJson(Map<String, dynamic> json) {
    return ComDate(
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
