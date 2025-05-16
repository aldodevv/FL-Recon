import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/annotations.dart';
import 'package:recon/bloc/concurrent_bloc/concurrent_bloc.dart';
import 'package:recon/bloc/concurrent_bloc/concurrent_event.dart';
import 'package:recon/bloc/concurrent_bloc/concurrent_state.dart';
import 'package:recon/bloc/droppable_bloc/droppable_bloc.dart';
import 'package:recon/bloc/droppable_bloc/droppable_event.dart';
import 'package:recon/bloc/droppable_bloc/droppable_state.dart';
import 'package:recon/bloc/restartable_bloc/restartable_bloc.dart';
import 'package:recon/bloc/restartable_bloc/restartable_event.dart';
import 'package:recon/bloc/restartable_bloc/restartable_state.dart';
import 'package:recon/bloc/sequential_bloc/sequential_bloc.dart';
import 'package:recon/bloc/sequential_bloc/sequential_event.dart';
import 'package:recon/bloc/sequential_bloc/sequential_state.dart';

@RoutePage()
class TransformerBlocPage extends StatelessWidget {
  const TransformerBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ConcurrentBloc()),
        BlocProvider(create: (_) => SequentialBloc()),
        BlocProvider(create: (_) => DroppableBloc()),
        BlocProvider(create: (_) => RestartableBloc()),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Bloc Transformer Demo')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              _buildBlocSection<ConcurrentBloc, ConcurrentState, ConcurrentEvent>(
                context,
                title: 'Concurrent',
                stateBuilder: (state) => state.count,
                eventBuilder: () => IncrementConcurrent(),
              ),
              _buildBlocSection<SequentialBloc, SequentialState, SequentialEvent>(
                context,
                title: 'Sequential',
                stateBuilder: (state) => state.count,
                eventBuilder: () => IncrementSequential(),
              ),
              _buildBlocSection<DroppableBloc, DroppableState, DroppableEvent>(
                context,
                title: 'Droppable',
                stateBuilder: (state) => state.count,
                eventBuilder: () => IncrementDroppable(),
              ),
              _buildBlocSection<RestartableBloc, RestartableState, RestartableEvent>(
                context,
                title: 'Restartable',
                stateBuilder: (state) => state.count,
                eventBuilder: () => IncrementRestartable(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlocSection<B extends Bloc<E, S>, S, E>(
    BuildContext context, {
    required String title,
    required int Function(S state) stateBuilder,
    required E Function() eventBuilder,
  }) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text('$title Count: ${stateBuilder(state)}'),
            trailing: ElevatedButton(
              onPressed: () => context.read<B>().add(eventBuilder()),
              child: const Text('Increment'),
            ),
          ),
        );
      },
    );
  }
}