import 'package:flutter/material.dart';
import "package:gameaiupdate/services/auth.dart";
import "package:gameaiupdate/services/database.dart";
import 'package:provider/provider.dart';
import "package:gameaiupdate/screens/home/lessonlist.dart";
import "package:gameaiupdate/screens/home/setting.dart";
import "package:gameaiupdate/screens/profile/profilepage.dart";
import "package:gameaiupdate/screens/profile/editprofilepage.dart";
import "package:gameaiupdate/screens/home/profileimagewidget.dart";
import 'package:cached_network_image/cached_network_image.dart';

class MyHomePage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showUserPannel() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            //return SettingPage(context);
            return ProfilePage();
            //return EditProfilePage();
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('පාඩම'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            print('Clicked Iconbutton');
          },
        ),
        actions: <Widget>[
          ProfileImageWidget(
            imagePath: 'https://media.istockphoto.com/photos/portrait-of-a-happy-latin-american-boy-smiling-picture-id1271410473',
            onClicked: () async {
              //_showUserPannel();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
        flexibleSpace: Image.asset(
          "assets/appbar_image.png",
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
        elevation: 10,
      ),
      body: LessonList(),
    );
  }
}
