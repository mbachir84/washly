import 'package:get/get.dart';

enum Comment { notWashedProperly, newDamages, inappropriateBehavior }

class ContactWasherController extends GetxController {
  Comment comment = Comment.notWashedProperly;
}
