import 'package:all_sm_friends/services/models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/firestore_functions.dart';
import '../../shared/themes/colors.dart';
import '../../shared/themes/text.dart';
import '../../shared/widget/action_button.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key, required this.user});
  final MyUser user;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final FocusNode numberNode = FocusNode();
  final TextEditingController facebookController = TextEditingController();
  final FocusNode faceookNode = FocusNode();
  final TextEditingController instagramController = TextEditingController();
  final FocusNode instagramNode = FocusNode();
  final TextEditingController whatsappController = TextEditingController();
  final FocusNode whatsappNode = FocusNode();
  final TextEditingController youtubeController = TextEditingController();
  final FocusNode youtubeNode = FocusNode();
  final TextEditingController githubController = TextEditingController();
  final FocusNode githubNode = FocusNode();
  final TextEditingController linkedinController = TextEditingController();
  final FocusNode linkedinNode = FocusNode();
  final TextEditingController tiktokController = TextEditingController();
  final FocusNode tiktokNode = FocusNode();

  void setData() {
    nameController.text = user.name;
    numberController.text = user.phoneNumber;
    facebookController.text = user.socialMediaPlatforms['facebook'] ?? '';
    instagramController.text = user.socialMediaPlatforms['instagram'] ?? '';
    whatsappController.text = user.socialMediaPlatforms['whatsapp'] ?? '';
    youtubeController.text = user.socialMediaPlatforms['youtube'] ?? '';
    githubController.text = user.socialMediaPlatforms['github'] ?? '';
    linkedinController.text = user.socialMediaPlatforms['linkedin'] ?? '';
    tiktokController.text = user.socialMediaPlatforms['tiktok'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    setData();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: orange,
          ),
          title: Text(
            'Edit Profile',
            style: h5,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      //name
                      TextFormField(
                        // onFieldSubmitted: (value) {
                        //   FocusScope.of(context).requestFocus(numberNode);
                        // },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "number can't be empty";
                          }
                          return null;
                        },
                        controller: nameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            FontAwesomeIcons.user,
                            color: orange,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: red,
                              width: 2,
                            ),
                          ),
                          label: Text(
                            '  User name',
                            style:
                                titel2.merge(TextStyle(color: grey.shade400)),
                          ),

                          //hintText: 'enter the phone number', hintStyle: body,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: grey,
                              width: 2,
                            ),
                          ),
                        ),
                        cursorColor: white,
                        style: titel1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //phone number
                      TextFormField(
                        // onFieldSubmitted: (value) {
                        //   FocusScope.of(context).requestFocus(faceookNode);
                        // },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "number can't be empty";
                          }
                          return null;
                        },
                        focusNode: numberNode,
                        controller: numberController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            FontAwesomeIcons.phone,
                            color: orange,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: red,
                              width: 2,
                            ),
                          ),
                          label: Text(
                            '  Phone Number',
                            style:
                                titel2.merge(TextStyle(color: grey.shade400)),
                          ),

                          //hintText: 'enter the phone number', hintStyle: body,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: grey,
                              width: 2,
                            ),
                          ),
                        ),
                        cursorColor: white,
                        style: titel1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'Edit Social Media',
                          style: h3,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //facebook
                      TextFormField(
                        validator: (value) =>
                            RegExp(r"^(https?:\/\/(.+?\.)?facebook\.com(\/[A-Za-z0-9\-\._~:\/\?#\[\]@!$&'\(\)\*\+,;\=]*)?)")
                                        .hasMatch(value!) ||
                                    value.isEmpty
                                ? null
                                : 'Not a valid facebook link',
                        focusNode: faceookNode,
                        controller: facebookController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              launchUrl(Uri.parse('https://www.facebook.com/'),
                                  mode: LaunchMode.externalApplication);
                            },
                            icon: Icon(
                              FontAwesomeIcons.squareArrowUpRight,
                              color: orange,
                              size: 20,
                            ),
                          ),
                          prefixIcon: Icon(
                            FontAwesomeIcons.facebook,
                            color: blue,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: red,
                              width: 2,
                            ),
                          ),
                          label: Text(
                            'enter a Facebook link',
                            style:
                                titel2.merge(TextStyle(color: grey.shade400)),
                          ),

                          // hintText: 'enter the phone number',
                          // hintStyle: body,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: grey,
                              width: 2,
                            ),
                          ),
                        ),
                        cursorColor: white,
                        style: titel1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //insta
                      TextFormField(
                        validator: (value) =>
                            RegExp(r"^(https?:\/\/(.+?\.)?instagram\.com(\/[A-Za-z0-9\-\._~:\/\?#\[\]@!$&'\(\)\*\+,;\=]*)?)")
                                        .hasMatch(value!) ||
                                    value.isEmpty
                                ? null
                                : 'Not a valid instagram link',
                        focusNode: instagramNode,
                        controller: instagramController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            FontAwesomeIcons.instagram,
                            color: Colors.pink,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: red,
                              width: 2,
                            ),
                          ),
                          label: Text(
                            'enter a Instagram link',
                            style:
                                titel2.merge(TextStyle(color: grey.shade400)),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              launchUrl(Uri.parse('https://www.instagram.com/'),
                                  mode: LaunchMode.externalApplication);
                            },
                            icon: Icon(
                              FontAwesomeIcons.squareArrowUpRight,
                              color: orange,
                              size: 20,
                            ),
                          ),
                          //hintText: 'enter the phone number', hintStyle: body,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: grey,
                              width: 2,
                            ),
                          ),
                        ),
                        cursorColor: white,
                        style: titel1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //whatsapp
                      TextFormField(
                        validator: (value) => RegExp(r'(^(?:[+0])?[0-9]{12}$)')
                                    .hasMatch(value!) ||
                                value.isEmpty
                            ? null
                            : 'Not a valid whatsapp number',
                        focusNode: whatsappNode,
                        controller: whatsappController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            FontAwesomeIcons.whatsapp,
                            color: green,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: red,
                              width: 2,
                            ),
                          ),
                          label: Text(
                            'enter a Whatsapp number',
                            style:
                                titel2.merge(TextStyle(color: grey.shade400)),
                          ),
                          hintText: 'Please enter +20',
                          hintStyle: body,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: grey,
                              width: 2,
                            ),
                          ),
                        ),
                        cursorColor: white,
                        style: titel1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //LINKEDIN
                      TextFormField(
                        validator: (value) =>
                            RegExp(r"^(https?:\/\/(.+?\.)?linkedin\.com(\/[A-Za-z0-9\-\._~:\/\?#\[\]@!$&'\(\)\*\+,;\=]*)?)")
                                        .hasMatch(value!) ||
                                    value.isEmpty
                                ? null
                                : 'Not a valid linkedin link',
                        focusNode: linkedinNode,
                        controller: linkedinController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              launchUrl(Uri.parse('https://www.linkedin.com/'),
                                  mode: LaunchMode.externalApplication);
                            },
                            icon: Icon(
                              FontAwesomeIcons.squareArrowUpRight,
                              color: orange,
                              size: 20,
                            ),
                          ),
                          prefixIcon: Icon(
                            FontAwesomeIcons.linkedin,
                            color: blue,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: red,
                              width: 2,
                            ),
                          ),
                          label: Text(
                            'enter a LinkedIn link',
                            style:
                                titel2.merge(TextStyle(color: grey.shade400)),
                          ),

                          //hintText: 'enter the phone number', hintStyle: body,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: grey,
                              width: 2,
                            ),
                          ),
                        ),
                        cursorColor: white,
                        style: titel1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //GitHub
                      TextFormField(
                        validator: (value) =>
                            RegExp(r"^(https?:\/\/(.+?\.)?github\.com(\/[A-Za-z0-9\-\._~:\/\?#\[\]@!$&'\(\)\*\+,;\=]*)?)")
                                        .hasMatch(value!) ||
                                    value.isEmpty
                                ? null
                                : 'Not a valid github link',
                        focusNode: githubNode,
                        controller: githubController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              launchUrl(Uri.parse('https://github.com/'),
                                  mode: LaunchMode.externalApplication);
                            },
                            icon: Icon(
                              FontAwesomeIcons.squareArrowUpRight,
                              color: orange,
                              size: 20,
                            ),
                          ),
                          prefixIcon: Icon(
                            FontAwesomeIcons.github,
                            color: white,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: red,
                              width: 2,
                            ),
                          ),
                          label: Text(
                            'enter a GitHub link',
                            style:
                                titel2.merge(TextStyle(color: grey.shade400)),
                          ),

                          //hintText: 'enter the phone number', hintStyle: body,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: grey,
                              width: 2,
                            ),
                          ),
                        ),
                        cursorColor: white,
                        style: titel1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //youtube
                      TextFormField(
                        validator: (value) =>
                            RegExp(r"^(https?:\/\/(.+?\.)?youtube\.com(\/[A-Za-z0-9\-\._~:\/\?#\[\]@!$&'\(\)\*\+,;\=]*)?)")
                                        .hasMatch(value!) ||
                                    value.isEmpty
                                ? null
                                : 'Not a valid youtube link',
                        focusNode: youtubeNode,
                        controller: youtubeController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              launchUrl(Uri.parse('https://www.youtube.com/'),
                                  mode: LaunchMode.externalApplication);
                            },
                            icon: Icon(
                              FontAwesomeIcons.squareArrowUpRight,
                              color: orange,
                              size: 20,
                            ),
                          ),
                          prefixIcon: Icon(
                            FontAwesomeIcons.youtube,
                            color: red,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: red,
                              width: 2,
                            ),
                          ),
                          label: Text(
                            'enter a Youtube link',
                            style:
                                titel2.merge(TextStyle(color: grey.shade400)),
                          ),

                          //hintText: 'enter the phone number', hintStyle: body,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: grey,
                              width: 2,
                            ),
                          ),
                        ),
                        cursorColor: white,
                        style: titel1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //Tiktok
                      TextFormField(
                        validator: (value) =>
                            RegExp(r"^(https?:\/\/(.+?\.)?tiktok\.com(\/[A-Za-z0-9\-\._~:\/\?#\[\]@!$&'\(\)\*\+,;\=]*)?)")
                                        .hasMatch(value!) ||
                                    value.isEmpty
                                ? null
                                : 'Not a valid tiktok link',
                        focusNode: tiktokNode,
                        controller: tiktokController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              launchUrl(Uri.parse('https://www.tiktok.com/'),
                                  mode: LaunchMode.externalApplication);
                            },
                            icon: Icon(
                              FontAwesomeIcons.squareArrowUpRight,
                              color: orange,
                              size: 20,
                            ),
                          ),
                          prefixIcon: Icon(
                            FontAwesomeIcons.tiktok,
                            color: white,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: red,
                              width: 2,
                            ),
                          ),
                          label: Text(
                            'enter a TikTok link',
                            style:
                                titel2.merge(TextStyle(color: grey.shade400)),
                          ),

                          //hintText: 'enter the phone number', hintStyle: body,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: white,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: grey,
                              width: 2,
                            ),
                          ),
                        ),
                        cursorColor: white,
                        style: titel1,
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //the button
                      SizedBox(
                        width: double.infinity,
                        child: ActionButton(
                          titel: 'Update Profile',
                          titelstyle: h5,
                          action: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (formkey.currentState!.validate()) {
                              FirestoreServices().updateProfileData(
                                context: context,
                                updateName: nameController.text,
                                updateNumber: numberController.text,
                                updatefacebook: facebookController.text,
                                updateinstagram: instagramController.text,
                                updatewhatsapp: whatsappController.text,
                                updateyoutube: youtubeController.text,
                                updategithub: githubController.text,
                                updatelinkedin: linkedinController.text,
                                updatetiktok: tiktokController.text,
                              );
                            }
                          },
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
