import 'package:domi_assignment/routes/app_route_constants.dart';
import 'package:domi_assignment/feature/map_screen/presentation/pages/HomePage.dart'
    as hs;
import 'package:domi_assignment/theme/app_pallete.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isanimate = true;
  bool isanimate1 = true;
  bool isanimate2 = true;
  bool isanimate3 = true;
  bool isanimate4 = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isanimate = false;
      });
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isanimate1 = false;
      });
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        isanimate2 = false;
      });
    });
    Future.delayed(const Duration(milliseconds: 1700), () {
      setState(() {
        isanimate3 = false;
      });
    });
    Future.delayed(const Duration(milliseconds: 1900), () {
      setState(() {
        isanimate4 = false;
      });
    });
    Future.delayed(const Duration(milliseconds: 2200), () {
      context.goNamed(MyAppRouteConstant.homeScreenRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.bounceOut,
            right: width * 0.5 + 4,
            bottom: isanimate2 ? height * 0.5 - 24 : height * 0.5 + 4,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: isanimate2 ? 0 : 1,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(30)),
                child: const Center(
                    child: Text('O',
                        style: TextStyle(
                            color: AppPallete.whiteColor,
                            fontWeight: FontWeight.bold))),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutExpo,
            left: isanimate3 ? width * 0.5 - 24 : width * 0.5 + 4,
            top: height * 0.5 + 4,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 50),
              opacity: isanimate3 ? 0 : 1,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppPallete.greyColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                    child: Text('I',
                        style: TextStyle(
                            color: AppPallete.whiteColor,
                            fontWeight: FontWeight.bold))),
              ),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.easeOutBack,
            duration: const Duration(milliseconds: 200),
            left: width * 0.5 + 4,
            bottom: isanimate4 ? height * 0.5 - 24 : height * 0.5 + 4,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: isanimate4 ? 0 : 1,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                    child: Text('M',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))),
              ),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.easeInOutBack,
            duration: const Duration(milliseconds: 500),
            right: isanimate1 ? width * 0.5 - 10 : width * 0.5 + 4,
            top: isanimate1 ? height * 0.5 - 10 : height * 0.5 + 4,
            child: Container(
              width: 30,
              height: 30,
              color: Colors.black,
              child: const Center(
                  child: Text('D',
                      style: TextStyle(
                          color: AppPallete.whiteColor,
                          fontWeight: FontWeight.bold))),
            ),
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1),
              opacity: isanimate1 ? 1 : 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutCubicEmphasized,
                width: isanimate ? width : 30,
                height: isanimate ? height : 30,
                color: Colors.black,
                child: const Center(
                    child: Text('D',
                        style: TextStyle(
                            color: AppPallete.whiteColor,
                            fontWeight: FontWeight.bold))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
