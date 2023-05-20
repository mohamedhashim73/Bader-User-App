import 'package:bader_user_app/Core/Constants/enumeration.dart';
import 'package:bader_user_app/Features/Layout/Domain/Entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import '../../Features/Auth/Presentation/Controller/auth_cubit.dart';
import '../../Features/Clubs/Presentation/Controller/clubs_cubit.dart';
import '../../Features/Events/Domain/Entities/event_entity.dart';
import '../../Features/Events/Presentation/Controller/events_cubit.dart';
import '../../Features/Layout/Presentation/Controller/layout_cubit.dart';

class Constants {
  static dynamic providers = [
    BlocProvider(create: (context) => AuthCubit()),
    BlocProvider(create: (context) => ClubsCubit()),
    BlocProvider(create: (context) => EventsCubit()..getAllTasksOnApp()),
    BlocProvider(create: (context) => LayoutCubit()),
  ];
  static String? userID;
  static List<String> colleges = ["كلية علوم وهندسة الحاسب الآلي","كلية الآداب والعلوم الإنسانية","كلية إدارة الأعمال","كلية التربية","كلية التمريض","الكلية التطبيقية","كلية الحقوق","كلية الصيدلة","كلية الطب","كلية طب الأسنان","كلية العلوم","كلية علوم الأسرة","كلية علوم التأهيل الطبي","كلية العلوم الطبية التطبيقية","كلية الهندسة"];
  static List<String> reportTypes = ["خطة سنوية","فعالية","ساعات تطوعية"];
  static List<String> committees = ["التنظيمية" , "الإعلامية" , "التصميم"];
  static List<String> genderStatus = ["ذكر","أنثي"];
  static String kNotificationsCollectionName = "Notifications";
  static String kUsersCollectionName = "Users";
  static String kClubsCollectionName = "Clubs";
  static String kMeetingsCollectionName = "Meetings";
  static String kMembershipRequestsCollectionName = "Membership Requests";
  static String kTaskAuthenticationRequestsCollectionName = "Tasks Authentication Requests";
  static String kOpinionsAboutTaskCollectionName = "Opinions";
  static String kMembersDataCollectionName = "Members Data";
  static String kMembersNumberCollectionName = "Members Number";
  static String kTotalVolunteerHoursThrowAppCollectionName = "Volunteer Hours";
  static String kEventsCollectionName = "Events";
  static String kTasksCollectionName = "Tasks";
  static String kReportsCollectionName = "Reports";
  static String getTimeNow() => Jiffy(DateTime.now()).yMMMd;
  static Future<TimeOfDay?> selectTime({required BuildContext context}) async => await showTimePicker(context: context,initialTime: TimeOfDay.now());
  static Future<DateTime?> selectDate({required BuildContext context}) async => await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 365)),
  );
  static Future<XFile?> getImageFromGallery() async => await ImagePicker().pickImage(source: ImageSource.gallery);

  // TODO: هستخدمهم في عرض بيانات الفعاليه عشان بناء عليها هعمل action معين
  static bool eventExpiredAndIHaveNotJoined({required UserEntity userEntity,required bool eventExpired,required EventEntity event}){
    String eventID = event.id!;
    List? idForEventsJoined = userEntity.idForEventsJoined;
    return eventExpired && (idForEventsJoined == null || (idForEventsJoined.contains(eventID) == false));
  }

  static bool eventInDateAndIDoNotHavePermissionToJoin({required UserEntity userEntity,required bool eventExpired,required EventEntity event}){
    List? idForClubsMemberIn = userEntity.idForClubsMemberIn;
    bool eventNotPublic = event.forPublic == EventForPublicOrNot.public.name ? false : true;
    String clubID = event.clubID!;
    return eventNotPublic && !eventExpired && (idForClubsMemberIn == null || ( idForClubsMemberIn.contains(clubID) == false) );
  }

  static bool eventExpiredAndIHaveJoined({required UserEntity userEntity,required bool eventExpired,required EventEntity event}){
    String eventID = event.id!;
    List? idForEventsJoined = userEntity.idForEventsJoined;
    return eventExpired && (idForEventsJoined != null && idForEventsJoined.contains(eventID) == true);
  }

  static bool eventInDateAndIHaveJoined({required UserEntity userEntity,required bool eventExpired,required EventEntity event}){
    String eventID = event.id!;
    List? idForEventsJoined = userEntity.idForEventsJoined;
    return !eventExpired && (idForEventsJoined != null && idForEventsJoined.contains(eventID));
  }

  static bool eventInDateAndIHaveNotJoinedYetAndHavePermission({required UserEntity userEntity,required bool eventExpired,required EventEntity event}){
    bool eventForOnlyMembers = event.forPublic!.trim() == EventForPublicOrNot.public.name ? false : true;
    String eventID = event.id!;
    String clubID = event.clubID!;
    List? idForEventsJoined = userEntity.idForEventsJoined;
    List? idForClubsMemberIn = userEntity.idForClubsMemberIn;
    return (!eventForOnlyMembers && !eventExpired && idForEventsJoined == null || (idForEventsJoined != null && idForEventsJoined.contains(eventID) == false)) || (!eventExpired && ((idForClubsMemberIn != null && idForClubsMemberIn.contains(clubID) == true)));
  }
}