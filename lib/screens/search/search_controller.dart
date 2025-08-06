import 'dart:async';

import 'package:flutter/material.dart';
import 'package:golf_flutter/api/api_constants/api_key_constants.dart';
import 'package:golf_flutter/api/api_methods/api_methods.dart';
import 'package:golf_flutter/api/api_models/user_model.dart';

import '../../api/api_models/search_user_model.dart';
import '../../common/nm.dart';

class SearchDiscoverController extends ChangeNotifier {
  List<SearchUserData> filteredList = [];
  List<SearchUserData> searchUserData = [];

  TextEditingController searchController = TextEditingController();

  Timer? debounce;
  bool isSearchLoading = false;

  void searchOnChange({required String value}) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    isSearchLoading = true;
    notifyListeners();
    debounce = Timer(const Duration(milliseconds: 500), () async {
      isSearchLoading = false;
      if (value.isEmpty) {
        filteredList.clear();
        notifyListeners();
        return;
      }
      List<SearchUserData> tempList = [];
      SearchUserModel? searchUserModel =
          await ApiMethods.searchUser(queryParameters: {
        ApiKeyConstants.search: value.toLowerCase(),
      });
      searchUserData.clear();
      if (searchUserModel != null && searchUserModel.data != null) {
        searchUserData = searchUserModel.data!;
      }
      for (var item in searchUserData) {
        if (item.name!.toLowerCase().contains(value.toLowerCase())) {
          tempList.add(item);
        }
      }
      filteredList = tempList;
      notifyListeners();
    });
  }

  clickOnButton({required int index}) async {
    isSearchLoading = true;
    notifyListeners();

    if (!(filteredList[index].isFollowing ?? false)) {
      UserModel? userModel = await ApiMethods.follow(bodyParams: {
        ApiKeyConstants.userIdToFollow: filteredList[index].sId,
      });
      if (userModel != null) {
        filteredList[index].isFollowing =
        !(filteredList[index].isFollowing ?? false);
      }
    } else {
      UserModel? userModel = await ApiMethods.unFollow(bodyParams: {
        ApiKeyConstants.userIdToUnfollow: filteredList[index].sId,
      });
      if (userModel != null) {
        filteredList[index].isFollowing =
        !(filteredList[index].isFollowing ?? false);
      }
    }
    isSearchLoading = false;
    notifyListeners();
  }

  clickOnBackButton({required BuildContext context}) {
    NM.popMethod(context: context);
  }
}
