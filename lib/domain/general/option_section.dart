import '../entity/major.dart';
import '../entity/school.dart';

class OptionSection{
  String title;
  List<String> options;

  OptionSection({required this.title, required this.options});

  OptionSection.fromSchoolList(List<School> items):
    title = 'Schools',
    options = items.map((e) => e.schoolName).toList();

  OptionSection.fromMajorList(List<Major> items):
    title = 'Majors',
    options = items.map((e) => e.majorName).toList();

  OptionSection.empty():
    title = '',
    options = [];
}