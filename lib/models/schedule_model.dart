import 'package:mabeet_app/models/out_home_model.dart';
import 'package:mabeet_app/models/wife_stay_model.dart';

class ScheduleModel {
  final List<WifeStayModel> wivesStay; // قائمة الزوجات
  final Map<String, OutHomeModel>
  outHomeDays; // الفترات التي يكون فيها خارج المنزل

  ScheduleModel({required this.wivesStay, required this.outHomeDays});
}
