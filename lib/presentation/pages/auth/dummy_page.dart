import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recon/domain/repository/dummy_repository.dart';
import 'package:recon/presentation/bloc/dummy/dummy_bloc.dart';

@RoutePage()
class DummyPage extends StatelessWidget {
  const DummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocProvider(
        create: (context) => DummyBloc(DummyRepository())..add(FetchPosts()),
        child: BlocBuilder<DummyBloc, DummyState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.failure != null) {
              return Center(
                child: Text(
                  '${state.failure!.message} - ${state.failure!.type} - ${state.failure!.rc}',
                ),
              );
            }

            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (_, i) {
                final post = state.posts[i];
                return ListTile(title: Text(post.title), subtitle: Text(post.body));
              },
            );
          },
        ),
      ),
    );
  }
}
