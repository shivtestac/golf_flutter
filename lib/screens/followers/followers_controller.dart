import 'dart:async';

import 'package:flutter/material.dart';
import 'package:golf_flutter/api/api_models/my_following_model.dart';

import '../../api/api_constants/api_key_constants.dart';
import '../../api/api_methods/api_methods.dart';
import '../../api/api_models/my_followers_model.dart';
import '../../api/api_models/search_user_model.dart';
import '../../api/api_models/user_model.dart';
import '../../common/nm.dart';

class FollowersController extends ChangeNotifier{
  bool isInitCalled = false;
  String screenType= 'Followers';
  List<Followers> filteredList = [];
  List<Followers> searchUserData = [];
  List<Following> filteredFollowingList = [];
  List<Following> searchUserFollowingData = [];

  TextEditingController searchController = TextEditingController();

  bool isSearchLoading = false;

  void initMethod() async{
    if (!isInitCalled) {
      isSearchLoading=true;
      if(screenType=='Followers'){
        MyFollowersModel? myFollowersModel = await ApiMethods.myFollowers();
        if (myFollowersModel != null && myFollowersModel.followers != null
            && myFollowersModel.followers!.isNotEmpty) {
          searchUserData = myFollowersModel.followers!;
          filteredList = searchUserData;
        }
      }else{
        MyFollowingModel? myFollowingModel = await ApiMethods.myFollowing();
        if (myFollowingModel != null && myFollowingModel.following != null
            && myFollowingModel.following!.isNotEmpty) {
          searchUserFollowingData = myFollowingModel.following!;
          filteredFollowingList = searchUserFollowingData;
          print("Lenght:-----${filteredFollowingList.length}");
        }
      }

      isSearchLoading=false;
      notifyListeners();
    }
  }

  void searchOnChange({required String query}) async{
    if (query.isEmpty) {
      filteredList = searchUserData; // Show all items
    } else {
      filteredList = searchUserData
          .where((item) => item.name
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  clickOnButton({required int index}) async {
    isSearchLoading = true;
    notifyListeners();

    UserModel? userModel = await ApiMethods.unFollow(bodyParams: {
      ApiKeyConstants.userIdToUnfollow: filteredFollowingList[index].sId,
    });
    if (userModel != null) {
      filteredList.removeAt(index);
    }
    isSearchLoading = false;
    notifyListeners();
  }

  clickOnBackButton({required BuildContext context}) {
    NM.popMethod(context: context);
  }

}