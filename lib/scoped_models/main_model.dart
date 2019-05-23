import 'package:scoped_model/scoped_model.dart';

import 'supply.dart';
import 'bill_board_model.dart';
import 'chores_model.dart';

class MainModel extends Model with SupplyModel, BillBoardModel, ChoresModel {}