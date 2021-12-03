import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mydevapp/getx_state_manegement/getx_controller_userprofile.dart';
import 'package:mydevapp/modal/api_models.dart';

class UsersProfile extends StatelessWidget {
  UsersProfile({Key? key}) : super(key: key);

  UserProfileController userProfileController =
      Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (userProfileController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: userProfileController.userprofilelist.length,
                    itemBuilder: (BuildContext context, index) {
                      return ShowUser(
                          usersProfile:
                              userProfileController.userprofilelist[index]);
                    });
              }
            }),
          ),
        ],
      ),
    );
  }
}

class ShowUser extends StatelessWidget {
  const ShowUser({Key? key, required this.usersProfile}) : super(key: key);
  final DataFormUser usersProfile;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: ListView.builder(
              itemCount: usersProfile.toString().length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: context.size!.height,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: [
                        Container(
                          height: context.size!.height * 0.05,
                          color: Colors.amberAccent,
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    usersProfile.data!.profilePic!),
                              ),
                              Text(usersProfile.data!.emailId!),
                              Text(usersProfile.data!.name!),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
