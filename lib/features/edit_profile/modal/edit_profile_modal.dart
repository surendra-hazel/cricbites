// To parse this JSON data, do
//
//     final editUserProfileModal = editUserProfileModalFromJson(jsonString);

import 'dart:convert';

EditUserProfileModal editUserProfileModalFromJson(String str) => EditUserProfileModal.fromJson(json.decode(str));

String editUserProfileModalToJson(EditUserProfileModal data) => json.encode(data.toJson());

class EditUserProfileModal {
  int? status;
  String? message;
  Data? data;

  EditUserProfileModal({
    this.status,
    this.message,
    this.data,
  });

  factory EditUserProfileModal.fromJson(Map<String, dynamic> json) => EditUserProfileModal(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  int? referId;
  dynamic name;
  String? username;
  String? mobile;
  dynamic email;
  String? dob;
  String? gender;
  String? fcmToken;
  String? socialLoginType;
  String? deviceId;
  String? jwtToken;
  String? customUserToken;
  String? image;
  String? activationStatus;
  String? code;
  int? emailCode;
  String? provider;
  dynamic socialId;
  dynamic googleId;
  dynamic facebookId;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? team;
  int? isTeamUpdated;
  int? isEmailUpdated;
  int? mobileVerify;
  int? emailVerify;
  int? panVerify;
  int? aadharVerify;
  int? bankVerify;
  dynamic banid;
  dynamic paytmBenid;
  String? refercode;
  int? referCount;
  int? emailbonus;
  int? mobilebonus;
  int? panbonus;
  int? bankbonus;
  dynamic token;
  int? referToJoin;
  int? adminReferred;
  int? playerPercentage;
  int? isYoububer;
  int? isYoutuber;
  String? youtuberCommission;
  String? youtuberCommissionType;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? signupbonus;
  int? referbonus;
  int? isNewUser;
  int? isJoinedBonusGiven;
  int? isJoinedRefralGiven;
  int? isBot;
  int? isUltimate11User;
  int? isInterestAdded;
  String? registerType;
  String? profileImage;
  int? isActive;
  dynamic beneId;
  int? isMobileActive;
  dynamic deactivateMessage;
  int? signupBonusReceived;
  String? dataDeviceId;

  Data({
    this.id,
    this.referId,
    this.name,
    this.username,
    this.mobile,
    this.email,
    this.dob,
    this.gender,
    this.fcmToken,
    this.socialLoginType,
    this.deviceId,
    this.jwtToken,
    this.customUserToken,
    this.image,
    this.activationStatus,
    this.code,
    this.emailCode,
    this.provider,
    this.socialId,
    this.googleId,
    this.facebookId,
    this.address,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.team,
    this.isTeamUpdated,
    this.isEmailUpdated,
    this.mobileVerify,
    this.emailVerify,
    this.panVerify,
    this.aadharVerify,
    this.bankVerify,
    this.banid,
    this.paytmBenid,
    this.refercode,
    this.referCount,
    this.emailbonus,
    this.mobilebonus,
    this.panbonus,
    this.bankbonus,
    this.token,
    this.referToJoin,
    this.adminReferred,
    this.playerPercentage,
    this.isYoububer,
    this.isYoutuber,
    this.youtuberCommission,
    this.youtuberCommissionType,
    this.createdAt,
    this.updatedAt,
    this.signupbonus,
    this.referbonus,
    this.isNewUser,
    this.isJoinedBonusGiven,
    this.isJoinedRefralGiven,
    this.isBot,
    this.isUltimate11User,
    this.isInterestAdded,
    this.registerType,
    this.profileImage,
    this.isActive,
    this.beneId,
    this.isMobileActive,
    this.deactivateMessage,
    this.signupBonusReceived,
    this.dataDeviceId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    referId: json["refer_id"],
    name: json["name"],
    username: json["username"],
    mobile: json["mobile"],
    email: json["email"],
    dob: json["dob"],
    gender: json["gender"],
    fcmToken: json["fcmToken"],
    socialLoginType: json["socialLoginType"],
    deviceId: json["deviceId"],
    jwtToken: json["jwt_token"],
    customUserToken: json["custom_user_token"],
    image: json["image"],
    activationStatus: json["activation_status"],
    code: json["code"],
    emailCode: json["email_code"],
    provider: json["provider"],
    socialId: json["social_id"],
    googleId: json["google_id"],
    facebookId: json["facebook_id"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    pincode: json["pincode"],
    team: json["team"],
    isTeamUpdated: json["is_team_updated"],
    isEmailUpdated: json["is_email_updated"],
    mobileVerify: json["mobile_verify"],
    emailVerify: json["email_verify"],
    panVerify: json["pan_verify"],
    aadharVerify: json["aadhar_verify"],
    bankVerify: json["bank_verify"],
    banid: json["banid"],
    paytmBenid: json["paytm_benid"],
    refercode: json["refercode"],
    referCount: json["refer_count"],
    emailbonus: json["emailbonus"],
    mobilebonus: json["mobilebonus"],
    panbonus: json["panbonus"],
    bankbonus: json["bankbonus"],
    token: json["token"],
    referToJoin: json["refer_to_join"],
    adminReferred: json["admin_referred"],
    playerPercentage: json["player_percentage"],
    isYoububer: json["is_yoububer"],
    isYoutuber: json["is_youtuber"],
    youtuberCommission: json["youtuber_commission"],
    youtuberCommissionType: json["youtuber_commission_type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    signupbonus: json["signupbonus"],
    referbonus: json["referbonus"],
    isNewUser: json["is_new_user"],
    isJoinedBonusGiven: json["is_joined_bonus_given"],
    isJoinedRefralGiven: json["is_joined_refral_given"],
    isBot: json["is_bot"],
    isUltimate11User: json["is_ultimate11_user"],
    isInterestAdded: json["is_interest_added"],
    registerType: json["register_type"],
    profileImage: json["profile_image"],
    isActive: json["is_active"],
    beneId: json["beneId"],
    isMobileActive: json["is_mobile_active"],
    deactivateMessage: json["deactivate_message"],
    signupBonusReceived: json["signup_bonus_received"],
    dataDeviceId: json["device_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "refer_id": referId,
    "name": name,
    "username": username,
    "mobile": mobile,
    "email": email,
    "dob": dob,
    "gender": gender,
    "fcmToken": fcmToken,
    "socialLoginType": socialLoginType,
    "deviceId": deviceId,
    "jwt_token": jwtToken,
    "custom_user_token": customUserToken,
    "image": image,
    "activation_status": activationStatus,
    "code": code,
    "email_code": emailCode,
    "provider": provider,
    "social_id": socialId,
    "google_id": googleId,
    "facebook_id": facebookId,
    "address": address,
    "city": city,
    "state": state,
    "country": country,
    "pincode": pincode,
    "team": team,
    "is_team_updated": isTeamUpdated,
    "is_email_updated": isEmailUpdated,
    "mobile_verify": mobileVerify,
    "email_verify": emailVerify,
    "pan_verify": panVerify,
    "aadhar_verify": aadharVerify,
    "bank_verify": bankVerify,
    "banid": banid,
    "paytm_benid": paytmBenid,
    "refercode": refercode,
    "refer_count": referCount,
    "emailbonus": emailbonus,
    "mobilebonus": mobilebonus,
    "panbonus": panbonus,
    "bankbonus": bankbonus,
    "token": token,
    "refer_to_join": referToJoin,
    "admin_referred": adminReferred,
    "player_percentage": playerPercentage,
    "is_yoububer": isYoububer,
    "is_youtuber": isYoutuber,
    "youtuber_commission": youtuberCommission,
    "youtuber_commission_type": youtuberCommissionType,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "signupbonus": signupbonus,
    "referbonus": referbonus,
    "is_new_user": isNewUser,
    "is_joined_bonus_given": isJoinedBonusGiven,
    "is_joined_refral_given": isJoinedRefralGiven,
    "is_bot": isBot,
    "is_ultimate11_user": isUltimate11User,
    "is_interest_added": isInterestAdded,
    "register_type": registerType,
    "profile_image": profileImage,
    "is_active": isActive,
    "beneId": beneId,
    "is_mobile_active": isMobileActive,
    "deactivate_message": deactivateMessage,
    "signup_bonus_received": signupBonusReceived,
    "device_id": dataDeviceId,
  };
}
