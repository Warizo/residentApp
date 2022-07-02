class Token {
  int? iD;
  String? tokenID;
  String? residentID;
  String? residentName;
  String? residentAddress;
  String? visitor;
  String? visitorsEmail;
  int? visitorNo;
  String? reason;
  String? status;
  int? active;
  Login? login;
  Login? logOut;
  Login? generated;

  Token({
    this.iD,
    this.tokenID,
    this.residentID,
    this.residentName,
    this.residentAddress,
    this.visitor,
    this.visitorsEmail,
    this.visitorNo,
    this.reason,
    this.status,
    this.active,
    this.login,
    this.logOut,
    this.generated,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      iD: json['ID'],
      tokenID: json['TokenID'],
      residentID: json['ResidentID'],
      residentName: json['ResidentName'],
      residentAddress: json['ResidentAddress'],
      visitor: json['Visitor'],
      visitorsEmail: json['VisitorsEmail'],
      visitorNo: json['VisitorNo'],
      reason: json['Reason'],
      status: json['Status'],
      active: json['Active'],
      login: json['Login'] != null ? new Login.fromJson(json['Login']) : null,
      logOut:
          json['LogOut'] != null ? new Login.fromJson(json['LogOut']) : null,
      generated: json['Generated'] != null
          ? new Login.fromJson(json['Generated'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['TokenID'] = this.tokenID;
    data['ResidentID'] = this.residentID;
    data['ResidentName'] = this.residentName;
    data['ResidentAddress'] = this.residentAddress;
    data['Visitor'] = this.visitor;
    data['VisitorsEmail'] = this.visitorsEmail;
    data['VisitorNo'] = this.visitorNo;
    data['Reason'] = this.reason;
    data['Status'] = this.status;
    data['Active'] = this.active;
    if (this.login != null) {
      data['Login'] = this.login!.toJson();
    }
    if (this.logOut != null) {
      data['LogOut'] = this.logOut!.toJson();
    }
    if (this.generated != null) {
      data['Generated'] = this.generated!.toJson();
    }
    return data;
  }
}

class Login {
  String? date;
  int? timezoneType;
  String? timezone;

  Login({this.date, this.timezoneType, this.timezone});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
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
