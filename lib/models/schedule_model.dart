import 'package:mabeet_app/models/out_home_model.dart';
import 'package:mabeet_app/models/wife_model.dart';

class ScheduleModel {
  final Map<String, WifeModel> wives; // قائمة الزوجات
  final Map<String, OutHomeModel>
  outHomeDays; // الفترات التي يكون فيها خارج المنزل

  ScheduleModel({required this.wives, required this.outHomeDays});
}
