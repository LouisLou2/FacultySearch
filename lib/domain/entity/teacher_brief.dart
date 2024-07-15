class TeacherBrief{
  String teacherId;
  String teacherName;
  String schoolName;
  String majorName;
  String title;
  String picUrl;

  TeacherBrief({
    required this.teacherId,
    required this.teacherName,
    required this.schoolName,
    required this.majorName,
    required this.title,
    required this.picUrl,
  });

  factory TeacherBrief.fromJson(Map<String, dynamic> json) {
    return TeacherBrief(
      teacherId: json['teacherId'],
      teacherName: json['teacherName'],
      schoolName: json['schoolName'],
      majorName: json['majorName'],
      title: json['title'],
      picUrl: json['picUrl'],
    );
  }
}