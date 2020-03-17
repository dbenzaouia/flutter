import 'dart:async';

import 'package:flutter_app/models/stepsModel.dart';
import 'package:flutter_app/database.dart';

class StepsManager{
  
  final DBProvider dbProvider;

  StepsManager(this.dbProvider);
  
  Future<void>addNewSteps(Steps steps) async{
    print('here');
    return dbProvider.addNewSteps(steps); 
  }

}