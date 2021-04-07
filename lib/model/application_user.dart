class ApplicationUser {
  String userGuid;
  String firstName;
  String midName;
  String lastName;
  String cosTele4;
  String cosTele1;
  String cosTele2;
  String gender;
  String cosCode;
  String locality;
  String cosName;
  String cosCompany;
  String userImage;
  String cosAd;
  String cosEmail;
  bool remmberme;
  String gymGuid;
  List<dynamic> user_role;

  ApplicationUser(
      {this.userGuid,
      this.firstName,
      this.midName,
      this.lastName,
      this.cosTele4,
      this.cosTele1,
      this.cosTele2,
      this.gender,
      this.cosCode,
      this.locality,
      this.cosName,
      this.cosCompany,
      this.userImage,
      this.cosAd,
      this.cosEmail,
      this.remmberme,
      this.gymGuid,
      this.user_role});

  ApplicationUser.fromJson(Map<String, dynamic> json) {
    userGuid = json['userGuid'];
    firstName = json['firstName'];
    midName = json['midName'];
    lastName = json['lastName'];
    cosTele4 = json['cos_tele4'];
    cosTele1 = json['cos_tele1'];
    cosTele2 = json['cos_tele2'];
    gender = json['gender'];
    cosCode = json['cos_code'];
    locality = json['locality'];
    cosName = json['cos_name'];
    cosCompany = json['cos_Company'];
    userImage = json['user_image'];
    cosAd = json['cos_ad'];
    cosEmail = json['cos_Email'];
    remmberme = json['remmberme'];
    gymGuid = json['gymGuid'];
    user_role = json['user_role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userGuid'] = "'${this.userGuid}'";
    data['firstName'] = "'${this.firstName}'";
    data['midName'] = "'${this.midName}'";
    data['lastName'] = "'${this.lastName}'";
    data['cos_tele4'] = "'${this.cosTele4}'";
    data['cos_tele1'] = "'${this.cosTele1}'";
    data['cos_tele2'] = "'${this.cosTele2}'";
    data['gender'] = "'${this.gender}'";
    data['cos_code'] = "'${this.cosCode}'";
    data['locality'] = "'${this.locality}'";
    data['cos_name'] = "'${this.cosName}'";
    data['cos_Company'] = "'${this.cosCompany}'";
    data['user_image'] = "'${this.userImage}'";
    data['cos_ad'] = "'${this.cosAd}'";
    data['cos_Email'] = "'${this.cosEmail}'";
    data['remmberme'] = "'${this.remmberme}'";
    data['gymGuid'] = "'${this.gymGuid}'";

    for (int i = 0; i < this.user_role.length; i++) {
      this.user_role[i] = "'${this.user_role[i]}'";
    }
    data['user_role'] = this.user_role;
    return data;
  }
}
