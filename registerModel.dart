class RegisterModel {
  String? firstName;
  String? lastName;
  String? dob;
  String? mobileNo;
  String? email;
  String? pincode;
  int? governmentProof;
  bool? termsAccepted;
  bool? wVerify;


  RegisterModel({
    this.firstName,
    this.lastName,
    this.dob,
    this.mobileNo,
    this.email,
    this.pincode,
    this.governmentProof,
    this.termsAccepted,
    this.wVerify,

  });

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'dob': dob,
      'mobile_no': mobileNo,
      'email': email,
      'pincode': pincode,
      'governmentproof': governmentProof,
      'terms_accepted': termsAccepted,
      'w_verify': wVerify,

    };
  }

  // Factory to create a model from JSON response (if needed)
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      dob: json['dob'],
      mobileNo: json['mobile_no'],
      email: json['email'],
      pincode: json['pincode'],
      governmentProof: json['governmentproof'],
      termsAccepted: json['terms_accepted'],
      wVerify: json['w_verify'],

    );
  }
}