import 'package:assignment12_front_end/core/api.dart';
import 'package:dio/dio.dart';

class ContactForm {
  String title;
  String content;
  String email;

  ContactForm(
      {required this.title, required this.content, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'email': email,
    };
  }
}

class ContactFormRepository {
  final _api = Api();

  Future<void> sendMail(String title, String content, String email) async {
    try {
      ContactForm contactForm = ContactForm(
        title: title,
        content: content,
        email: email,
      );

      Map<String, dynamic> formData = contactForm.toJson();

      Response response = await _api.sendRequest.post('/email', data: formData);

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
    } catch (error) {
      rethrow;
    }
  }
}
