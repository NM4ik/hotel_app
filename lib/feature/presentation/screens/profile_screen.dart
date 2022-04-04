import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/core/locator_service.dart';

import '../../../common/app_constants.dart';
import '../../../core/platform/network_info.dart';
import '../bloc/profile_bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 500),
    );
  }

  List<String> data = ['Page 0', 'Page 1', 'Page 2'];
  int initPosition = 1;

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(ProfileAuthEvent());

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitialState) {
          return const CircularProgressIndicator();
        }
        if (state is ProfileAuthenticatedState) {
          return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              // body: SingleChildScrollView(
              //   child: Column(
              //     children: [

              // Expanded(
              //   child: ListView.builder(physics: BouncingScrollPhysics(), itemCount: 50, itemBuilder: (context, index) => Text('index')),
              // ),
              body: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width / 1.2,
                        decoration: const BoxDecoration(
                          color: kMainBlueColor,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                        ),
                      ),
                      SafeArea(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
                        child: Column(
                          children: [
                            const Center(
                              child: Text(
                                'Профиль',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22),
                              ),
                            ),
                            const SizedBox(
                              height: kEdgeVerticalPadding,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(99),
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: Image.asset("assets/images/profile_image.png"),
                            ),
                            const SizedBox(
                              height: kEdgeVerticalPadding / 2,
                            ),
                            Column(
                              children: const [
                                Text(
                                  'Victoria Robertson',
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'A mantra goes here??',
                                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(kEdgeMainBorder * 3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TabBar(
                        indicator: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(kEdgeMainBorder * 3),
                        ),
                        controller: tabController,
                        tabs: [
                          Tab(
                            text: 'Информация',
                          ),
                          Tab(text: 'Посещения'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(100.0),
                                child: Text('qwe'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(100.0),
                                child: Text('qwe'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(100.0),
                                child: Text('qwe'),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          itemBuilder: (context, index) => Text('qwe'),
                          itemCount: 300,
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        } else {
          return const Text('qwe');
        }
      },
    );
  }
}
