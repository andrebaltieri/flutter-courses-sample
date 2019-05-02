import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:pizzabox/models/course.model.dart';

class CourseRepository {
  Client client = Client();

  Future<List<CourseModel>> get() async {
    final response = await client.get("https://api.balta.io/v1/courses");

    if (response.statusCode == 200) {
      var list = json.decode(response.body) as List<dynamic>;
      var courses = new List<CourseModel>();

      for (dynamic item in list) {
        CourseModel course = new CourseModel();
        course.title = item["title"];
        course.tag = item["tag"];
        // course.price = item["price"];
        courses.add(course);
      }

      return courses;
    } else {
      throw Exception('Deu ruim!');
    }
  }
}
