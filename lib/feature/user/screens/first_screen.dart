import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_call_api_bloc/feature/user/model/user_model.dart';
import 'package:flutter_call_api_bloc/tools/snack_bar/snack_bar_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../bloc/user_bloc.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    context.read<UserBloc>().add(UserDataFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<UserBloc, UserState>(
        buildWhen: (previous, current) {
          if (previous.userDataEvent == current.userDataEvent) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          if (state.userDataEvent is UserDataLoading) {
            return const ShimmerEffect();
          }
          if (state.userDataEvent is UserDataCompleted) {
            UserDataCompleted userDataCompleted =
                state.userDataEvent as UserDataCompleted;
            List<UserModel> userModel = userDataCompleted.userModel;

            return CompleteScreenWidget(userModel: userModel);
          }
          if (state.userDataEvent is UserDataError) {
            final UserDataError userDataError =
                state.userDataEvent as UserDataError;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userDataError.errorMessage,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade800),
                    onPressed: () {
                      /// call all data again
                      context.read<UserBloc>().add(UserDataFetch());
                    },
                    child: const Text("تلاش دوباره"),
                  )
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}

class CompleteScreenWidget extends StatelessWidget {
  const CompleteScreenWidget({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  final List<UserModel> userModel;

  @override
  Widget build(BuildContext context) {
    // final helper=userModel.da
    return RefreshIndicator(
      onRefresh: () async {
        context.read<UserBloc>().add(UserDataFetch());
      },
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            const Padding(padding: EdgeInsets.all(8.0), child: Divider()),
        itemCount: userModel.length,
        itemBuilder: (context, index) {
          final helper = userModel[index];
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
