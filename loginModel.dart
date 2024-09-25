class LoginModel {
  String? identifier;
  String? token;  // Assuming the response includes a token
  String? message;  // To handle any response message (optional)

  LoginModel({this.identifier, this.token,this.message});

  // Factory method to create an instance from JSON response
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'],  // Assuming token is part of the response
      message: json['message'],  // To handle any response message
    );
  }

  // Convert the model to JSON (for request payload)
  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
    };
  }
}