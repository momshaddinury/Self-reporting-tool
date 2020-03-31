import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selfreportingapp/model/patient_data.dart';
import 'package:selfreportingapp/screens/Report/possible_affected.dart';
import 'package:selfreportingapp/screens/Report/survey_page.dart';
import 'package:selfreportingapp/services/api.dart';
import 'package:selfreportingapp/services/firebase_auth.dart';
import 'package:selfreportingapp/services/json_handle.dart';
import 'package:url_launcher/url_launcher.dart';

class LogInToSubmit extends StatefulWidget {
  @override
  _LogInToSubmitState createState() => _LogInToSubmitState();
}

class _LogInToSubmitState extends State<LogInToSubmit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Container(
//          color: Colors.white,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                COVIDForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class COVIDForm extends StatefulWidget {
  @override
  _COVIDFormState createState() => _COVIDFormState();
}

class _COVIDFormState extends State<COVIDForm> {
  final formKey = GlobalKey<FormState>();
  final AuthService auth = AuthService();
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
              child: AutoSizeText(
                "আমার হাতেই আমার সুরক্ষা",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: AutoSizeText(
                "সঠিক তথ্য দিয়ে ফর্মটি পূর্ণ করুন। আপনার মোবাইল নম্বর ঠিক ভাবে দিন। নির্দেশনা মেনে চলুন",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FormBuilder(
              // context,
              key: _fbKey,
              readOnly: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Name
                  FormBuilderTextField(
                    attribute: "name",
                    decoration: InputDecoration(
                      labelText: "নাম?",
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    onSaved: (value) => fullName = value,
                  ),

                  // Contact Number:
                  FormBuilderTextField(
                    attribute: "phonenumber",
                    decoration: InputDecoration(
                      labelText: "ফোন নম্বর [১১ ডিজিট]",
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    keyboardType: TextInputType.number,
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.minLength(11,
                          errorText: "১১ ডিজিট"),
                      FormBuilderValidators.maxLength(11, errorText: "১১ ডিজিট")
                    ],
                    onSaved: (value) => phoneNumber = value,
                  ),

                  // NID:
                  FormBuilderTextField(
                    attribute: "number",
                    decoration: InputDecoration(
                      labelText: "এন আই ডি [১০ ডিজিট এবং অপশনাল]",
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => nid = value,
                  ),

                  // Passport:
                  /*FormBuilderTextField(
                    attribute: "number",
                    decoration: InputDecoration(
                      labelText: "পাসপোর্ট আইডি [৯ ডিজিট]",
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => passportID = value,
                  ),*/

                  // Gender:
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: AutoSizeText("লিঙ্গ"),
                  ),
                  FormBuilderChoiceChip(
                    attribute: 'choice_chip',
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    options: [
                      FormBuilderFieldOption(
                        value: 'পুরুষ',
                        child: Text('পুরুষ'),
                      ),
                      FormBuilderFieldOption(
                        value: 'মহিলা',
                        child: Text('মহিলা'),
                      ),
                      FormBuilderFieldOption(
                        value: 'অন্যান্য',
                        child: Text('অন্যান্য'),
                      )
                    ],
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    onSaved: (value) => gender = value,
                  ),

                  // Age
                  FormBuilderTextField(
                    attribute: "age",
                    decoration: InputDecoration(
                      labelText: "আপনার বয়স?",
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ],
                    onSaved: (value) => age = value,
                    keyboardType: TextInputType.number,
                  ),

                  // Fever:
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: AutoSizeText(
                        "আপনার কি জ্বর আছে বা জ্বরজ্বর অনুভব করছেন?"),
                  ),
                  FormBuilderChoiceChip(
                    attribute: 'choice_chip',
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    options: [
                      FormBuilderFieldOption(
                        value: 'হ্যাঁ',
                        child: Text('হ্যাঁ'),
                      ),
                      FormBuilderFieldOption(value: 'না', child: Text('না')),
                    ],
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    onSaved: (value) {
                      if (value == "হ্যাঁ") {
                        fever = true;
                      } else {
                        fever = false;
                      }
                    },
                  ),

                  // কাশি বা গলাব্যথা বা দুইটাই:
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: AutoSizeText(
                        "আপনার কি কাশি বা গলাব্যথা বা দুইটাই আছে?"),
                  ),
                  FormBuilderChoiceChip(
                    attribute: 'choice_chip',
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    options: [
                      FormBuilderFieldOption(
                        value: 'হ্যাঁ',
                        child: Text('হ্যাঁ'),
                      ),
                      FormBuilderFieldOption(value: 'না', child: Text('না')),
                    ],
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    onSaved: (value) {
                      if (value == "হ্যাঁ") {
                        coughOrThroatPain = true;
                      } else {
                        coughOrThroatPain = false;
                      }
                    },
                  ),

                  // শ্বাসকষ্ট:
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: AutoSizeText(
                        "আপনার কি শ্বাসকষ্ট আছে বা শ্বাস নিতে বা ফেলতে কষ্ট হচ্ছে?"),
                  ),
                  FormBuilderChoiceChip(
                    attribute: 'choice_chip',
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    options: [
                      FormBuilderFieldOption(
                        value: 'হ্যাঁ',
                        child: Text('হ্যাঁ'),
                      ),
                      FormBuilderFieldOption(value: 'না', child: Text('না')),
                    ],
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    onSaved: (value) {
                      if (value == "হ্যাঁ") {
                        problemBreathing = true;
                      } else {
                        problemBreathing = false;
                      }
                    },
                  ),

                  // Migrant:
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: AutoSizeText(
                        "আপনি কি বিগত ১৪ দিনের ভিতরে বিদেশ হতে এসেছেন?"),
                  ),
                  FormBuilderChoiceChip(
                    attribute: 'choice_chip',
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    options: [
                      FormBuilderFieldOption(
                        value: 'হ্যাঁ',
                        child: Text('হ্যাঁ'),
                      ),
                      FormBuilderFieldOption(value: 'না', child: Text('না')),
                    ],
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    onSaved: (value) {
                      if (value == "হ্যাঁ") {
                        cameBackFromAbroad = true;
                      } else {
                        cameBackFromAbroad = false;
                      }
                    },
                  ),

                  //Came in Contact with NRB:
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10),
                    child: AutoSizeText(
                        "আপনি কি বিগত ১৪ দিনের ভিতরে করোনা ভাইরাসে ( কোভিড -১৯) আক্রান্ত এরকম কোন ব্যক্তির সংস্পর্শে এসেছিলেন ( একই স্থানে অবস্থান বা ভ্রমন )?"),
                  ),
                  FormBuilderChoiceChip(
                    attribute: 'choice_chip',
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    options: [
                      FormBuilderFieldOption(
                        value: 'হ্যাঁ',
                        child: Text('হ্যাঁ'),
                      ),
                      FormBuilderFieldOption(value: 'না', child: Text('না')),
                    ],
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    onSaved: (value) {
                      if (value == "হ্যাঁ") {
                        contactWithAnyCOVIDPatient = true;
                      } else {
                        contactWithAnyCOVIDPatient = false;
                      }
                    },
                  ),

                  // আপনি কি বিগত ১৪ দিনের ভিতরে শ্বাসকষ্ট বা কাশিতে  আক্রান্ত এরকম কোন ব্যক্তির সংস্পর্শে এসেছিলেন?
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10),
                    child: AutoSizeText(
                        "বিগত ১৪ দিনে জর, কাশি, শ্বাসকষ্ট আছে এমন কারোর সংস্পর্শে কি আপনি এসেছিলেন ( পরিবার সদস্য / অফিস কলিগ ) ?"),
                  ),
                  FormBuilderChoiceChip(
                    attribute: 'choice_chip',
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    options: [
                      FormBuilderFieldOption(
                        value: 'হ্যাঁ',
                        child: Text('হ্যাঁ'),
                      ),
                      FormBuilderFieldOption(value: 'না', child: Text('না')),
                    ],
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    onSaved: (value) {
                      if (value == "হ্যাঁ") {
                        cameInContactWithPersonHavingCoughOrThroatPain = true;
                      } else {
                        cameInContactWithPersonHavingCoughOrThroatPain = false;
                      }
                    },
                  ),

                  //  আপনার কি অন্য কোন অসুখে  ভুগছেন (যেমন : ডায়াবেটিস, এজমা বা হাঁপানি , দীর্ঘমেয়াদি শ্বাসকষ্টের রোগ বা সিওপিডি, কিডনি রোগ, ক্যান্সার বা ক্যান্সারের জন্য কোন চিকিৎসা নিচ্ছেন?
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10),
                    child: AutoSizeText(
                        "আপনার কি অন্য কোন অসুখে  ভুগছেন (যেমন : ডায়াবেটিস, এজমা বা হাঁপানি , দীর্ঘমেয়াদি শ্বাসকষ্টের রোগ বা সিওপিডি, কিডনি রোগ, ক্যান্সার বা ক্যান্সারের জন্য কোন চিকিৎসা নিচ্ছেন?"),
                  ),
                  FormBuilderChoiceChip(
                    attribute: 'choice_chip',
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    options: [
                      FormBuilderFieldOption(
                        value: 'হ্যাঁ',
                        child: Text('হ্যাঁ'),
                      ),
                      FormBuilderFieldOption(value: 'না', child: Text('না')),
                    ],
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    onSaved: (value) {
                      if (value == "হ্যাঁ") {
                        riskGroup = true;
                      } else {
                        riskGroup = false;
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    color: Colors.red,
                    child: Text(
                      "ফিরে যান",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      toast("অপেক্ষা করুন");
                      _fbKey.currentState.reset();
                      // await auth.signOut();
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "রিসেট",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      toast("অপেক্ষা করুন");
                      _fbKey.currentState.reset();
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: MaterialButton(
                    color: Colors.green,
                    child: Text(
                      "জমা দিন",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      toast("অপেক্ষা করুন");
                      if (_fbKey.currentState.saveAndValidate()) {
                        toast("প্রসেসিং");

                        print(_fbKey.currentState.value);
                        //await orgLoginResponse();
                        await submitResponse();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("টেস্ট রেজাল্ট"),
                            content: SingleChildScrollView(
                              child: new Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      child: RichText(
                                    text: TextSpan(
                                      text: 'ফলাফল: $assessmentMessage\n',
                                      style: TextStyle(
                                        color: Colors.red,
                                        decoration: TextDecoration.none,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "\nআইডি: $userID\n",
                                          style: TextStyle(
                                            color: Colors.red,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                  Html(
                                    data: """$notes""",
                                    onLinkTap: (url) async {
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                },
                                textColor: Theme.of(context).primaryColor,
                                child: const Text('ওকে'),
                              ),
                            ],
                          ),
                        );
                        //await auth.signOut();
                        toast("সফল ভাবে জমা হয়েছে");
                      } else {
                        print(_fbKey.currentState.value);
                        toast("পুনরায় চেক করুন");
                        print("ভেলিডেশন ফেইল্ড");
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

toast(String label) {
  Fluttertoast.showToast(
      msg: label,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.blueAccent,
      textColor: Colors.white,
      fontSize: 16.0);
}
