import 'package:bader_user_app/Features/Layout/Domain/Entities/notification_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../Core/Errors/failure.dart';
import '../Entities/user_entity.dart';

// TODO: Contract Repository
abstract class LayoutBaseRepository{

  // TODO: USER
  Future<Either<Failure, UserEntity>> getMyData();
  Future<bool> updateMyData({required String name,required String college,required String gender,required int phone});
  Future<bool> logOut();


  // TODO: Notifications
  Future<Either<Failure,List<NotificationEntity>>> getNotifications();
  Future<bool> sendANotification({required String receiverID});

}