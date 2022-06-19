import 'package:untitled/form/Item.dart';
import 'package:untitled/form/check.dart';
import 'package:untitled/form/count.dart';
import 'package:untitled/form/paid.dart';
import 'conf.dart';

class Answer {
  late Item? item = Item();
  late Count? count = Count();
  late Conf? confirm = Conf();
  late Check? check = Check();
  late Paid? paid = Paid();

  Answer({this.item, this.count, this.confirm, this.check, this.paid});

  Answer.fromJson(Map<dynamic, dynamic> json) {
    var _item = json['item'];
    var _count = json['count'];
    var _confirm = json['confirm'];
    var _check = json['check'];
    var _paid = json['paid'];
    item = Item.fromJson(_item);
    count = Count.fromJson(_count);
    if (_confirm != null) {
      confirm = Conf.fromJson(_confirm);
    }
    if (_check != null) {
      check = Check.fromJson(_check);
    }
    if (_paid != null) {
      paid = Paid.fromJson(_paid);
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['item'] = item?.toJson();
    data['count'] = count?.toJson();
    data['confirm'] = confirm?.toJson();
    data['check'] = check?.toJson();
    data['paid'] = paid?.toJson();
    return data;
  }
}