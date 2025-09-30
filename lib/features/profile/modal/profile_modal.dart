// To parse this JSON data, do
//
//     final userProfileModal = userProfileModalFromJson(jsonString);

import 'dart:convert';

UserProfileModal userProfileModalFromJson(String str) => UserProfileModal.fromJson(json.decode(str));

String userProfileModalToJson(UserProfileModal data) => json.encode(data.toJson());

class UserProfileModal {
  int? status;
  Result? result;

  UserProfileModal({
    this.status,
    this.result,
  });

  factory UserProfileModal.fromJson(Map<String, dynamic> json) => UserProfileModal(
    status: json["status"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result?.toJson(),
  };
}

class Result {
  int? id;
  String? username;
  String? name;
  String? mobile;
  dynamic email;
  String? dob;
  String? dayOfBirth;
  String? monthOfBirth;
  String? yearOfBirth;
  String? gender;
  String? bio;
  String? image;
  String? address;
  String? city;
  String? pincode;
  int? walletamaount;
  int? verified;
  String? activationStatus;
  String? provider;
  String? state;
  String? country;
  String? refercode;
  ActivePlan? activePlan;
  List<ActivePlan>? subscribeTransaction;
  List<OfferCard>? offerCards;

  Result({
    this.id,
    this.username,
    this.name,
    this.mobile,
    this.email,
    this.dob,
    this.dayOfBirth,
    this.monthOfBirth,
    this.yearOfBirth,
    this.gender,
    this.bio,
    this.image,
    this.address,
    this.city,
    this.pincode,
    this.walletamaount,
    this.verified,
    this.activationStatus,
    this.provider,
    this.state,
    this.country,
    this.refercode,
    this.activePlan,
    this.subscribeTransaction,
    this.offerCards,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    username: json["username"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    dob: json["dob"],
    dayOfBirth: json["DayOfBirth"],
    monthOfBirth: json["MonthOfBirth"],
    yearOfBirth: json["YearOfBirth"],
    gender: json["gender"],
    bio: json["bio"],
    image: json["image"],
    address: json["address"],
    city: json["city"],
    pincode: json["pincode"],
    walletamaount: json["walletamaount"],
    verified: json["verified"],
    activationStatus: json["activation_status"],
    provider: json["provider"],
    state: json["state"],
    country: json["country"],
    refercode: json["refercode"],
    activePlan: json["active_plan"] == null ? null : ActivePlan.fromJson(json["active_plan"]),
    subscribeTransaction: json["subscribe_transaction"] == null ? [] : List<ActivePlan>.from(json["subscribe_transaction"]!.map((x) => ActivePlan.fromJson(x))),
    offerCards: json["offer_cards"] == null ? [] : List<OfferCard>.from(json["offer_cards"]!.map((x) => OfferCard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "name": name,
    "mobile": mobile,
    "email": email,
    "dob": dob,
    "DayOfBirth": dayOfBirth,
    "MonthOfBirth": monthOfBirth,
    "YearOfBirth": yearOfBirth,
    "gender": gender,
    "bio": bio,
    "image": image,
    "address": address,
    "city": city,
    "pincode": pincode,
    "walletamaount": walletamaount,
    "verified": verified,
    "activation_status": activationStatus,
    "provider": provider,
    "state": state,
    "country": country,
    "refercode": refercode,
    "active_plan": activePlan?.toJson(),
    "subscribe_transaction": subscribeTransaction == null ? [] : List<dynamic>.from(subscribeTransaction!.map((x) => x.toJson())),
    "offer_cards": offerCards == null ? [] : List<dynamic>.from(offerCards!.map((x) => x.toJson())),
  };
}

class ActivePlan {
  int? id;
  String? planName;
  String? description;
  int? amount;
  String? currency;
  String? durationType;
  int? durationValue;
  DateTime? validityStart;
  DateTime? validityEnd;
  List<String>? features;
  String? status;
  String? paymentMethod;
  String? transactionId;

  ActivePlan({
    this.id,
    this.planName,
    this.description,
    this.amount,
    this.currency,
    this.durationType,
    this.durationValue,
    this.validityStart,
    this.validityEnd,
    this.features,
    this.status,
    this.paymentMethod,
    this.transactionId,
  });

  factory ActivePlan.fromJson(Map<String, dynamic> json) => ActivePlan(
    id: json["id"],
    planName: json["plan_name"],
    description: json["description"],
    amount: json["amount"],
    currency: json["currency"],
    durationType: json["duration_type"],
    durationValue: json["duration_value"],
    validityStart: json["validity_start"] == null ? null : DateTime.parse(json["validity_start"]),
    validityEnd: json["validity_end"] == null ? null : DateTime.parse(json["validity_end"]),
    features: json["features"] == null ? [] : List<String>.from(json["features"]!.map((x) => x)),
    status: json["status"],
    paymentMethod: json["payment_method"],
    transactionId: json["transaction_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "plan_name": planName,
    "description": description,
    "amount": amount,
    "currency": currency,
    "duration_type": durationType,
    "duration_value": durationValue,
    "validity_start": "${validityStart!.year.toString().padLeft(4, '0')}-${validityStart!.month.toString().padLeft(2, '0')}-${validityStart!.day.toString().padLeft(2, '0')}",
    "validity_end": "${validityEnd!.year.toString().padLeft(4, '0')}-${validityEnd!.month.toString().padLeft(2, '0')}-${validityEnd!.day.toString().padLeft(2, '0')}",
    "features": features == null ? [] : List<dynamic>.from(features!.map((x) => x)),
    "status": status,
    "payment_method": paymentMethod,
    "transaction_id": transactionId,
  };
}

class OfferCard {
  int? id;
  String? title;
  String? description;
  String? image;
  String? offerCode;
  String? discountType;
  int? discountValue;
  DateTime? validFrom;
  DateTime? validTill;
  String? status;

  OfferCard({
    this.id,
    this.title,
    this.description,
    this.image,
    this.offerCode,
    this.discountType,
    this.discountValue,
    this.validFrom,
    this.validTill,
    this.status,
  });

  factory OfferCard.fromJson(Map<String, dynamic> json) => OfferCard(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    offerCode: json["offer_code"],
    discountType: json["discount_type"],
    discountValue: json["discount_value"],
    validFrom: json["valid_from"] == null ? null : DateTime.parse(json["valid_from"]),
    validTill: json["valid_till"] == null ? null : DateTime.parse(json["valid_till"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "offer_code": offerCode,
    "discount_type": discountType,
    "discount_value": discountValue,
    "valid_from": "${validFrom!.year.toString().padLeft(4, '0')}-${validFrom!.month.toString().padLeft(2, '0')}-${validFrom!.day.toString().padLeft(2, '0')}",
    "valid_till": "${validTill!.year.toString().padLeft(4, '0')}-${validTill!.month.toString().padLeft(2, '0')}-${validTill!.day.toString().padLeft(2, '0')}",
    "status": status,
  };
}
