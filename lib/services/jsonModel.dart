import 'dart:convert';

import 'package:covidtrackerbd/model/patientDataModel.dart';
import 'package:covidtrackerbd/services/locatioinService.dart';

String data = jsonEncode({
  "data": {
    "age": {"type": "number", "question": "আপনার বয়স? ", "answer": "$age"},
    "name": {
      "type": "text",
      "question_bn": "আপনার নাম?",
      "question_en": "Your Name?",
      "answer": "$fullName"
    },
    "is_feverish": {
      "type": "boolean",
      "question": "আপনার কি জ্বর আছে বা জ্বরজ্বর অনুভব করছেন?",
      "answer": "$fever"
    },
    "has_sore_throat": {
      "type": "boolean",
      "question": "আপনার কি কাশি বা গলাব্যথা বা দুইটাই আছে? ",
      "answer": "$coughOrThroatPain"
    },
    "has_breathlessness": {
      "type": "boolean",
      "question": "আপনার কি শ্বাসকষ্ট আছে বা শ্বাস নিতে বা ফেলতে কষ্ট হচ্ছে?",
      "answer": "$problemBreathing"
    },
    "is_visited_abroad": {
      "type": "boolean",
      "question": "আপনি কি বিগত ১৪ দিনের ভিতরে বিদেশ হতে এসেছেন?",
      "answer": "$cameBackFromAbroad"
    },
    "is_contacted_with_covid": {
      "type": "boolean",
      "question":
          "আপনি কি বিগত ১৪ দিনের ভিতরে করোনা ভাইরাসে ( কোবিড-১৯) আক্রান্ত এরকম কোন ব্যক্তির সংস্পর্শে এসেছিলেন ( একই স্থানে অবস্থান বা ভ্রমন )",
      "answer": "$contactWithAnyCOVIDPatient"
    },
    "is_contacted_with_family_who_cough": {
      "type": "boolean",
      "question":
          "গত ১৪ দিনে জর, কাশি, শ্বাসকষ্ট আছে এমন কারোর সংস্পর্শে কি আপনি এসেছিলেন ( পরিবার সদস্য / অফিস কলিগ )? ",
      "answer": "$cameInContactWithPersonHavingCoughOrThroatPain"
    },
    "high_risk": {
      "type": "boolean",
      "question":
          "আপনার কি অন্য কোন অসুখে  ভুগছেন (যেমন : ডায়াবেটিস, এজমা বা হাঁপানি , দীর্ঘমেয়াদি শ্বাসকষ্টের রোগ বা সিওপিডি, কিডনি রোগ, ক্যান্সার বা ক্যান্সারের জন্য কোন চিকিৎসা নিচ্ছেন?",
      "answer": "$riskGroup"
    },
    "location": {
      "latitude": position.latitude,
      "longitude": position.longitude,
      "altitude": position.altitude
    },
    //"name": "$fullName",
    "nid": nid,
    "address": "",
    "organization_id": "OXtgz8sE6xQ9UuCPlsNHfnrGmwz1 ",
    "organization_name": "C19BD-app",
    "status": "",
    "passport_id": "$passportID",
    "user_phone": phoneNumber,
    "metadata": {},
    "submitted_at": DateTime.now().millisecondsSinceEpoch,
    "updated_at": DateTime.now().millisecondsSinceEpoch
  }
});