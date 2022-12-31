import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_call_api_bloc/tools/snack_bar/snack_bar_widget.dart';
import 'package:flutter_call_api_bloc/user/bloc/user_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../cosntance/enum.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    context.read<UserBloc>().add(FetchUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<UserBloc, UserState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const ShimmerEffect();
          } else if (state.status == Status.complete) {
            return  CompleteScreenWidget(state: state);
          } else if (state.status == Status.error) {
            return RefreshIndicator(
              onRefresh: () async{
                context.read<UserBloc>().add(FetchUserEvent());
              },
              child: ListView(
                children: [
                  Text(
                    state.error.errMsg,
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              ),
            );
          }
          return const Center(
              child: Text('initial', style: TextStyle(fontSize: 30)));
        },
        listener: (context, state) {
          if (state.status == Status.error) {
            snackBarErrorWidget(context, state.error.errMsg);
          }
        },
      ),
    );
  }
}

class CompleteScreenWidget extends StatelessWidget {
  const CompleteScreenWidget({
    Key? key, required this.state,
  }) : super(key: key);

  final UserState state;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        context.read<UserBloc>().add(FetchUserEvent());
      },
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            const Padding(padding: EdgeInsets.all(8.0), child: Divider()),
        itemCount: state.userModel.length,
        itemBuilder: (context, index) {
          final helper = state.userModel[index];
          return ListTile(
            title: Text(helper.name),
            subtitle: Text(helper.email),
            trailing: Text(
              helper.gender,
              style: const TextStyle(color: Colors.green),
            ),
            leading: helper.status == 'inactive'
                ? const Icon(Icons.disabled_by_default, color: Colors.red)
                : const Icon(Icons.check_circle, color: Colors.green),
          );
        },
      ),
    );
  }
}

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (context, index) => SizedBox(
        width: double.infinity,
        height: 100,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
