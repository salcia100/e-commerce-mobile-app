import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/auth_api.dart';
import 'package:inscri_ecommerce/api/avatar_api.dart';
import 'package:inscri_ecommerce/model/Avatar.dart';
import 'package:inscri_ecommerce/model/user/User.dart';
import 'package:inscri_ecommerce/utils/toast.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  late User user;
  final APIService apiService = APIService();
  final AvatarApi avatarApiService = AvatarApi();
  String defaultAvatar = 'assets/profile/profile.jpg';
  String currentAvatar = '';
  String userName = '';
  String userEmail = '';
  List<Avatar> avatars = [];

  @override
  void initState() {
    super.initState();
    loadProfile();
    fetchAvatars();
  }

  void fetchAvatars() async {
    try {
      List<Avatar> data = await avatarApiService.getAvatars();
      setState(() {
        avatars = data;
      });
    } catch (e) {
      print("Erreur : $e");
    }
  }

  void loadProfile() async {
    try {
      user = await apiService.fetchProfile();
      setState(() {
        //currentAvatar = user.avatar?.image ?? defaultAvatar;
        userName = user.name;
        userEmail = user.email;
        currentAvatar = user.image;
      });
    } catch (e) {
      print("Error loading profile: $e");
    }
  }

  void _onAvatarSelected(int selectedAvatarId) async {
    bool success = await apiService.updateUserAvatar(selectedAvatarId);
    if (success) {
      successToast("Avatar Updated successfully !");
    } else {
      errorToast("Error updating avatar !");
    }
  }

  void _openAvatarPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: avatars.map((avatar) {
                return GestureDetector(
                  onTap: () {
                    print("Selected avatar: $avatar");
                    setState(() {
                      currentAvatar = avatar.image;
                    });
                    _onAvatarSelected(avatar.id); // Update avatar ID
                    Navigator.of(context).pop(); // Close dialog
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(avatar.image),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface,),
      currentAccountPicture: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 80, // augmente la taille
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(currentAvatar),
              onBackgroundImageError: (exception, stackTrace) {
                print('Failed to load image: $exception');
              },
            ),
          ),
          Positioned(
            bottom: -6,
            right: 0,
            child: GestureDetector(
              onTap: _openAvatarPicker,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(Icons.add, size: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      accountName: Text(
        userName,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      accountEmail: Text(userEmail, style: TextStyle(color: Colors.grey)),
    );
  }
}
