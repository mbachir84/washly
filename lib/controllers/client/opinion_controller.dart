import 'package:get/get.dart';

enum Opinion { urgent, wrongAddress }

class OpinionController extends GetxController {
  Opinion opinion = Opinion.urgent;
}
