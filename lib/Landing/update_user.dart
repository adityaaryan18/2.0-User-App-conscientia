import 'dart:convert';
import 'package:app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  void saveName(String firstname, String lastname, String uid) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://conscientia.co.in/api/updateUser/updateName"),
        body: json.encode(
            {'firstName': firstname, 'lastname': lastname, 'userId': uid}),
      );

      if (response.statusCode == 200) {
        debugPrint("Name updated successfully");
        print(response.body);
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error updating name: $e');
    }
  }

  void updateProfilePhoto(String imageUrl, String uid) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://conscientia.co.in/api/updateUser/updateProfile"),
        body: json.encode({
          'imageUrl': imageUrl,
          'userId': uid,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint("Profile photo updated successfully");
        print(response.body);
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error updating profile photo: $e');
    }
  }

  void updateMobile({
    required String uid,
    String? mobile,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://conscientia.co.in/api/updateUser/updateOther"),
        body: json.encode({
          'userId': uid,
          'mobile': mobile,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint("Mobile details updated successfully");
        print(response.body);
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error updating mobile details: $e');
    }
  }

  void updateCollege({
    required String uid,
    String? college,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://conscientia.co.in/api/updateUser/updateOther"),
        body: json.encode({
          'userId': uid,
          'college': college,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint("college name updated successfully");
        print(response.body);
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error updating college name : $e');
    }
  }

  void updateCollegeId({
    required String uid,
    String? collegeId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://conscientia.co.in/api/updateUser/updateOther"),
        body: json.encode({
          'userId': uid,
          'collegeId': collegeId,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint("College id updated successfully");
        print(response.body);
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error updating college id: $e');
    }
  }

  void updateAadhar({
    required String uid,
    String? aadhar,

  }) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://conscientia.co.in/api/updateUser/updateOther"),
        body: json.encode({
          'userId': uid,
          'aadhar': aadhar,

        }),
      );

      if (response.statusCode == 200) {
        debugPrint("Aadhar updated successfully");
        print(response.body);
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error updating Aadhar: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;
    final firebaseUser = context.watch<User?>();

    String? uid;
    if (firebaseUser != null) {
      uid = firebaseUser.uid;
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/login.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: user?.profile != null
                          ? NetworkImage(user!.profile!)
                          : AssetImage('assets/images/default_avatar.png')
                              as ImageProvider,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Let Us Know You',
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    Text('It is mandatory to fill every section', style: GoogleFonts.rubik(fontSize: 14,color: Colors.white),),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            context: context,
                            title: 'Username',
                            value: user?.username ?? '',
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _buildInfoCard(
                            context: context,
                            title: 'Force ID',
                            value: user?.forceId ?? '',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _buildInfoCard(
                      context: context,
                      title: 'Email',
                      value: user?.email ?? '',
                    ),
                    const SizedBox(height: 10),
                    _buildInfoCard(
                      context: context,
                      title: 'Name',
                      value: '${user?.firstName ?? ''} ${user?.lastName ?? ''}',
                      onTap: () => _showNameDialog(context, uid!),
                    ),
                    const SizedBox(height: 10),
                    _buildInfoCard(
                      context: context,
                      title: 'Mobile',
                      value: user?.mobile?.toString() ?? '',
                      onTap: () => _showInputDialog(
                        context,
                        title: "How can we reach you?",
                        labelText: 'Mobile',
                        initialValue: user?.mobile?.toString() ?? '',
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        uid: uid!,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildInfoCard(
                      context: context,
                      title: 'College',
                      value: user?.college ?? '',
                      onTap: () => _showInputDialog(
                        context,
                        title: "Seems like You are a warrior",
                        labelText: 'College',
                        initialValue: user?.college ?? '',
                        uid: uid!,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildInfoCard(
                      context: context,
                      title: 'College ID',
                      value: user?.collegeId ?? '',
                      onTap: () => _showInputDialog(
                        context,
                        title: "Beware of the Dark Forces",
                        labelText: 'College ID',
                        initialValue: user?.collegeId ?? '',
                        uid: uid!,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildInfoCard(
                      context: context,
                      title: 'Aadhaar',
                      value: user?.aadhar?.toString() ?? '',
                      onTap: () => _showInputDialog(
                        context,
                        title: "This is ",
                        labelText: 'Aadhar',
                        initialValue: user?.aadhar?.toString() ?? '',
                        keyboardType: TextInputType.number,
                        maxLength: 12,
                        uid: uid!,
                      ),
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.black.withOpacity(0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.rubik(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: GoogleFonts.rubik(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          trailing:
              onTap != null ? Icon(Icons.edit, color: Colors.white) : null,
        ),
      ),
    );
  }

  void _showNameDialog(BuildContext context, String uid,) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
  

    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: _buildCustomDialog(
            context: context,
            title: "Who exactly are you?",
            content: Column(
              mainAxisSize:
                  MainAxisSize.min, // Adjusts the size based on content
              children: [
                _buildTextField(
                  labelText:  'First Name',
                  context: context,
                  controller: firstNameController,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  labelText: 'Last Name',
                  context: context,
                  controller: lastNameController,
                ),
              ],
            ),
            onSave: () {
              saveName(firstNameController.text, lastNameController.text, uid);
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  void _showInputDialog(
    BuildContext context, {
    required String title,
    required String labelText,
    String? initialValue,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    required String uid,
  }) {
    final controller = TextEditingController(text: initialValue);

    showDialog(
      context: context,
      builder: (context) {
        return _buildCustomDialog(
          context: context,
          title: title,
          content: _buildTextField(
            labelText: labelText,
            context: context,
            controller: controller,
            keyboardType: keyboardType,
            maxLength: maxLength,
          ),
          onSave: () {
            // Update the relevant field based on the label
            if (labelText == 'Mobile') {
              updateMobile(uid: uid, mobile: controller.text);
            } else if (labelText == 'College') {
              updateCollege(uid: uid, college: controller.text);
            } else if (labelText == 'College ID') {
              updateCollegeId(uid: uid, collegeId: controller.text);
            } else if (labelText == 'Aadhar') {
              updateAadhar(uid: uid, aadhar: controller.text);
            }

            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Widget _buildTextField({
    required String labelText,
    required BuildContext context,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      style: GoogleFonts.rubik(color: Colors.white),
      decoration: InputDecoration(
        counterText: '', // Remove the character counter below the text field
        labelText: labelText,
        labelStyle: GoogleFonts.rubik(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildCustomDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    required VoidCallback onSave,
  }) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.black.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Adjusts the size based on content
          children: [
            Text(
              title,
              style: GoogleFonts.rubik(color: Color.fromARGB(255, 255, 77, 77), fontSize: 20),
            ),
            const SizedBox(height: 20),
            content,
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onSave,
                child: Text(
                  'Save',
                  style: GoogleFonts.rubik(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
