import 'package:kitabugar/theme/app_pallete.dart';
import 'package:kitabugar/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [content()],
    );
  }

  Container content() {
    return Container(
        height: 300,
        width: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/backgrounds/HeaderIllustration.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),

            //Selamat Datang
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 54,
                  top: 44,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Row(
                        //   children: [
                        //     const CircleAvatar(
                        //       backgroundColor: AppPallete.colorWhite,
                        //       child: Icon(Icons.person,
                        //           color: AppPallete.colorTextSecondary),
                        //     ),
                        //     const SizedBox(width: 8),
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           'Selamat datang!',
                        //           style: TextStyles.body3
                        //               .copyWith(color: AppPallete.colorWhite),
                        //         ),
                        //         Text('Kita Bugar, Kita Happy ',
                        //             style: TextStyles.body4.copyWith(
                        //               color: AppPallete.colorWhite,
                        //             )),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    const Gap(44),
                    Center(
                      child: Text(
                        "Prioritize Your Health",
                        style: TextStyles.heading3.copyWith(
                          color: AppPallete.colorWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
