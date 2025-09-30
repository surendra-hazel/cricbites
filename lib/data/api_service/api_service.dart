import 'dart:io';

import 'package:Cricbites/core/constants/app_constants.dart';
import 'package:Cricbites/features/all_series/data/modal/all_series_list_modal.dart';
import 'package:Cricbites/features/edit_profile/modal/edit_profile_modal.dart';
import 'package:Cricbites/features/feedback/presentation/modal/feedback_modal.dart';
import 'package:Cricbites/features/login/modal/login_modal.dart';
import 'package:Cricbites/features/more/presentation/modal/logout_modal.dart';
import 'package:Cricbites/features/otp_verification/presentation/modal/otp_verification_modal.dart';
import 'package:Cricbites/features/poll/presentation/data/poll_list_modal.dart';
import 'package:Cricbites/features/poll/presentation/data/poll_vote_modal.dart';
import 'package:Cricbites/features/profile/modal/profile_modal.dart';
import 'package:Cricbites/features/promote/presentation/modal/promote_app_modal.dart';
import 'package:Cricbites/features/quiz/presentation/data/quiz_join_modal.dart';
import 'package:Cricbites/features/quiz/presentation/data/quiz_list_modal.dart';
import 'package:Cricbites/features/ranking/data/modal/icc_ranking_modal.dart';
import 'package:Cricbites/features/refer_list/presentation/modal/refer_list_modal.dart';
import 'package:Cricbites/features/schedule/data/schedule_list_modal.dart';
import 'package:Cricbites/features/set_profile/presentation/modal/set_profile_image_modal.dart';
import 'package:Cricbites/features/set_profile/presentation/modal/set_profile_modal.dart';
import 'package:Cricbites/features/shorts/data/modal/shorts_list_modal.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  Future<LoginModal> loginMethod(String mobile) async {
    try {
      final response = await _dio.post(
        AppConstants.registerUrl,
        data: {"mobile": mobile},
      );

      if (response.statusCode == 201) {
        return LoginModal.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<OtpVerificationModal> loginOtpVerifyMethod(
      String mobile, String otp) async {
    try {
      final response = await _dio.post(
        AppConstants.verifyRegisterMobileOtp,
        data: {"mobile": mobile, "otp": otp},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return OtpVerificationModal.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<LoginModal> emailVerifyMethod(String mobile) async {
    try {
      final response = await _dio.post(
        AppConstants.emailRegister,
        data: {
          "email": mobile,
        },
      );

      if (response.statusCode == 201) {
        return LoginModal.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<LoginModal> emailOtpVerifyMethod(String mobile, String otp) async {
    try {
      final response = await _dio.post(
        AppConstants.verifyRegisterMobileOtp,
        data: {"mobile": mobile, "otp": otp},
      );

      if (response.statusCode == 201) {
        return LoginModal.fromJson(response.data); // Parse into model
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<SetProfileModal> setProfileMethod(
      {String? userId,
      String? userName,
      String? emailId,
      String? fullName,
      String? mobileNo,
      String? dob,
      String? gender,
      String? city,
      String? address,
      String? state,
      String? country}) async {
    try {
      final response = await _dio.post(AppConstants.updateTeamNameUrl, data: {
        "user_id": userId,
        "username": userName,
        "email_id": emailId,
        "name": fullName,
        "mobile": mobileNo,
        "dob": dob,
        "gender": gender,
        "city": city,
        "address": address,
        "state": state,
        "country": country,
        "pincode": "",
        "profile": ""
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        return SetProfileModal.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<SetProfileImageModal> uploadUserImage(
    String userId,
    File file,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'user_id': userId,
        'file': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      final response = await _dio.post(
        AppConstants.updateProfileImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        return SetProfileImageModal.fromJson(response.data);
      } else {
        throw Exception("Something went wrong: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Image upload failed: $e");
    }
  }

  Future<UserProfileModal> getUserProfileMethod(String userId) async {
    try {
      final response = await _dio.post(
        AppConstants.getUserProfile,
        data: {
          "user_id": userId,
        },
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return UserProfileModal.fromJson(response.data); // Parse into model
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<ReferListModal> getReferListMethod(String userId) async {
    try {
      final response = await _dio.post(
        AppConstants.referList,
        data: {
          "user_id": userId,
        },
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return ReferListModal.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<EditUserProfileModal> updateProfileMethod(
      {String? userId,
      String? userName,
      String? fullName,
      String? dob,
      String? gender,
      String? city,
      String? address,
      String? state,
      String? country}) async {
    try {
      final response = await _dio.post(AppConstants.editUserProfile, data: {
        "user_id": userId,
        "username": userName,
        "name": fullName,
        "dob": dob,
        "gender": gender,
        "city": city,
        "address": address,
        "state": state,
        "country": country,
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        return EditUserProfileModal.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<LogoutModal> logoutMethod({String? userId, String? mobileNo}) async {
    try {
      final response = await _dio.post(AppConstants.logout, data: {
        "user_id": userId,
        "mobile": mobileNo,
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        return LogoutModal.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<PromoteAppModal> addPromoteAppMethod(
      {Map<String, dynamic>? body}) async {
    try {
      final response = await _dio.post(
        AppConstants.addPromoteApp,
        data: body,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return PromoteAppModal.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<FeedbackModal> feedbackMethod({
    String? fullName,
    String? email,
    String? mobile,
    String? category,
    String? subject,
    String? description,
  }) async {
    try {
      final response = await _dio.post(
        AppConstants.feedback,
        data: {
          "full_name": fullName,
          "email": email,
          "mobile": mobile,
          "category": category,
          "subject": subject,
          "description": description
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return FeedbackModal.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<ScheduleListModal> scheduleListMethod({
    String? userId,
    String? matchStatus,
    String? competitionId,
  }) async {
    try {
      final response = await _dio.post(
        AppConstants.scheduleList,
        data: {
          "user_id": userId,
          "match_status": matchStatus,
          "comp_id": competitionId,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ScheduleListModal.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<Map<String, dynamic>> getHomeData() async {
    try {
      final response = await _dio.post("api/get-competition-matches");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  final String apiKey = "AIzaSyDFHtq3KwrJFodU5fagPjQJ1Cwe6z7CbyA";
  final String channelId = "UCGMDHzObapDZ5Ib8dq9PH3Q";

  Future<ShortsListModal> fetchYoutubeVideos({String? pageToken}) async {
    try {
      final response = await _dio.get(
        "https://www.googleapis.com/youtube/v3/search",
        queryParameters: {
          "part": "snippet",
          "channelId": channelId,
          "maxResults": 50,
          "order": "date",
          "type": "video",
          "key": apiKey,
          if (pageToken != null) "pageToken": pageToken,
        },
      );

      if (response.statusCode == 200) {
        return ShortsListModal.fromJson(response.data);
      } else {
        throw Exception("Failed to load YouTube videos");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<IccRankingListModal> rankingListMethod() async {
    try {
      final response = await _dio.get(
        AppConstants.rankList,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return IccRankingListModal.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<AllSeriesListModal> seriesListMethod() async {
    try {
      final response = await _dio.get(
        AppConstants.seriesList,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return AllSeriesListModal.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<QuizListModal> quizListMethod({String? userId}) async {
    try {
      final response = await _dio.post(
        AppConstants.quizList,
        data: {
          "user_id": userId
        }
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return QuizListModal.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<PollListModal> pollListMethod({String? userId}) async {
    try {
      final response = await _dio.post(
        AppConstants.pollList,
        data: {
          "user_id": userId
        }
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return PollListModal.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<QuizJoinModal> quizResponseSubmitMethod(
      {String? userId, String? optionId, String? questionId}) async {
    try {
      final response = await _dio.post(
        AppConstants.quizSubmit,
        data: {
          "user_id": userId,
          "option_id": optionId,
          "quizId": questionId,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return QuizJoinModal.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }

  Future<PollVoteModal> pollVoteMethod(
      {String? userId, String? optionId, String? questionId}) async {
    try {
      final response = await _dio.post(
        AppConstants.pollVote,
        data: {"user_id" : userId , "option_id" :optionId, "poll_id":questionId},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return PollVoteModal.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("API error: $e");
    }
  }
}
