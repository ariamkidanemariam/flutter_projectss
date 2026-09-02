import 'package:flutter/material.dart';
import 'package:postapp/screen/post_card.dart';
import 'package:postapp/viewModel/post_view_model.dart';
import 'package:provider/provider.dart';
import 'package:postapp/model/post.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PostScreenState();
  }
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostViewModel(),
      child: const _PostView(),
    );
  }
}

class _PostView extends StatelessWidget {
  const _PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: Consumer<PostViewModel>(
        builder: (context, postVm, _) {
          if (postVm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (postVm.error != null) {
            return Center(child: Text(postVm.error!));
          }

          final postList = postVm.postList;

          return ListView.builder(
            itemCount: postList?.length ?? 0,
            itemBuilder: (context, index) {
              return PostCard(post: postList![index]);
            },
          );
        },
      ),
    );
  }
}
