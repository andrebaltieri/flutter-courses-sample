class CourseModel {
  String title;
  String tag;
  double price;

  CourseModel({this.title, this.tag, this.price});

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      title: json['title'],
      tag: json['tag'],
      price: json['price'],
    );
  }
}