import 'package:flutter/foundation.dart';
import 'package:postapp/model/api_error.dart';
import 'package:postapp/service/post_api.dart';
import 'package:postapp/model/post.dart';

class PostViewModel extends ChangeNotifier {
  late final PostApi _postApi;
  List<Post>? postList;
  String ? error; 
  bool isLoading = false;

  PostViewModel({PostApi? postApi}) {
    _postApi = postApi ?? PostApi();
  }

  Future<void> fetchPosts() async {
    isLoading = true;
    error = null; 
    notifyListeners(); 

    try {
      postList = await _postApi.fetchPosts();
    } on ApiError catch (e) {
      error = e.message;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false; 
      notifyListeners(); 
    }
  }
}
