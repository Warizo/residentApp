class Vendor {
  int? iD;
  String? vendorCode;
  String? vendorname;
  String? vendorContact;
  String? vendorAddress;
  String? vendorEmail;
  String? vendorProfession;
  String? vendorTel;

  Vendor({
    this.iD,
    this.vendorCode,
    this.vendorname,
    this.vendorContact,
    this.vendorAddress,
    this.vendorEmail,
    this.vendorProfession,
    this.vendorTel,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      iD: json['ID'],
      vendorCode: json['VendorCode'],
      vendorname: json['Vendorname'],
      vendorContact: json['VendorContact'],
      vendorAddress: json['VendorAddress'],
      vendorEmail: json['VendorEmail'],
      vendorProfession: json['VendorProfession'],
      vendorTel: json['VendorTel'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ID'] = iD;
    data['VendorCode'] = vendorCode;
    data['Vendorname'] = vendorname;
    data['VendorContact'] = vendorContact;
    data['VendorAddress'] = vendorAddress;
    data['VendorEmail'] = vendorEmail;
    data['VendorProfession'] = vendorProfession;
    data['VendorTel'] = vendorTel;
    return data;
  }
}
