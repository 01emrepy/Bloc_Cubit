import 'package:bloc_cubit/cubit/store_cubit.dart';
import 'package:bloc_cubit/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreCubit(SampleStoreRepository()),
      child: bodyScaffold(context),
    );
  }

  Scaffold bodyScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cubit"),
      ),
      body: BlocConsumer<StoreCubit, StoreState>(
        listener: (context, state) {
          if (state is StoreError) {
            Scaffold.of(context)
                .showBottomSheet((context) => Text(state.message));
          }
        },
        builder: (context, state) {
          if (state is StoreInitial) {
            return Column(
              children: [
                const Text("data"),
                FloatingActionButton(
                  child: const Icon(Icons.menu),
                  onPressed: () {
                    context.read<StoreCubit>().getStore();
                  },
                ),
              ],
            );
          } else if (state is StoreLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Storecomplated) {
            return ListView.builder(
                itemCount: state.model.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading: Image.network(state.model[index].image!),
                    title: Text(state.model[index].title!),
                    subtitle: Text(state.model[index].description!),
                    trailing: Text(state.model[index].category!),
                  );
                }));
          } else {
            final error = state as StoreError;
            return Text(error.message);
          }
        },
      ),
    );
  }
}
