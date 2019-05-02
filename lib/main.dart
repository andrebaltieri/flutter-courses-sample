import 'package:flutter/material.dart';
import 'package:pizzabox/models/course.model.dart';
import 'package:pizzabox/repositories/course.repository.dart';
import 'dart:ui';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pizza Box",
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: "slabo",
        backgroundColor: Color(0xFF222428),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF222428),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 120,
            color: Color(0xFF1e2023),
            padding: EdgeInsets.only(top: 60, left: 10),
            child: Text(
              "Cursos",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: "slabo",
                fontSize: 45,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: 500,
            child: ListView(
              children: <Widget>[
                Container(
                  height: 500,
                  width: double.infinity,
                  child: courseList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget courseList() {
  CourseRepository _repository = new CourseRepository();

  return new FutureBuilder(
    future: _repository.get(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return Container(            
            height: 500,
            child: Text(
              "Carregando...",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "slabo",
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          );
        default:
          if (snapshot.hasError)
            return new Text(snapshot.error);
          else
            return showCourses(context, snapshot);
      }
    },
  );
}

Widget showCourses(BuildContext context, AsyncSnapshot snapshot) {
  List<CourseModel> courses = snapshot.data;

  return Container(
    padding: EdgeInsets.symmetric(vertical: 30),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: courses.length,
      itemBuilder: (BuildContext context, int i) {
        return ListOfCourse(
          title: courses[i].title,
          tag: courses[i].tag,
        );
      },
    ),
  );
}

class ListOfCourse extends StatelessWidget {
  const ListOfCourse({@required this.title, @required this.tag});

  final String title;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          margin: EdgeInsets.only(left: 10, right: 10),
          width: 300,
          decoration: BoxDecoration(
            color: Color(0xFF383a3e),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                width: 150.0,
                height: 150.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage(
                      "https://baltaio.blob.core.windows.net/student-images/1edd5c50-bae9-11e8-8eb4-39de303632c1.jpg",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "André Baltieri",
                textScaleFactor: 1.5,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 40,
              ),
              RichText(
                softWrap: true,
                text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: "slabo",
                    ),
                    children: [
                      TextSpan(
                        text: tag,
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      TextSpan(
                        text: "\n${title}",
                      ),
                    ]),
              ),
            ],
          ),
        )
      ],
    );
  }
}
