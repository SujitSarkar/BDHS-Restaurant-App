import 'package:bdhs_restaurant_app/core/widgets/solid_button.dart';
import 'package:bdhs_restaurant_app/src/features/authentication/repository/auth_repository.dart';
import 'package:bdhs_restaurant_app/src/features/profile/provider/profile_provider.dart';
import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/text_size.dart';
import '../../../../core/widgets/shimmer_widget.dart';
import '../../../../core/widgets/text_field_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    final ProfileProvider profileProvider = Provider.of(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await profileProvider.initializeData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProfileProvider profileProvider = Provider.of(context);
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: profileProvider.initialLoading
            ? ShimmerWidget(child: _bodyUI(context, profileProvider, size))
            : _bodyUI(context, profileProvider, size),
        floatingActionButton: IconButton(
          onPressed: () async {
            await AuthRepository().logout();
          },
          icon: const Icon(Icons.logout,color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      ),
    );
  }

  Widget _bodyUI(
          BuildContext context, ProfileProvider profileProvider, Size size) =>
      Column(
        children: [
          ///Header
          Stack(
            children: [
              Image.asset(
                'assets/images/login_header_bg.jpg',
                width: size.width,
                height: size.height * .25,
                fit: BoxFit.cover,
              ),
              Container(
                alignment: Alignment.center,
                width: size.width,
                height: size.height * .25,
                color: Colors.black.withOpacity(0.4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppColor.appBodyBg,
                      radius: 44,
                      child: Icon(Icons.person,
                          size: 64, color: AppColor.primaryColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${profileProvider.loginResponseModel?.user?.name ?? 'N/A'}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          height: 1,
                          color: Colors.white,
                          fontSize: TextSize.headerText,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          ///Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextFormFieldWidget(
                      controller: profileProvider.nameController,
                      labelText: 'Full Name',
                      hintText: 'Full Name',
                      onChanged: (value) =>
                          profileProvider.checkIsDataUpdatable(),
                      textInputType: TextInputType.name,
                      textCapitalization: TextCapitalization.words),
                  const SizedBox(height: 20),
                  TextFormFieldWidget(
                    controller: profileProvider.emailController,
                    labelText: 'Email Address',
                    hintText: 'Email Address',
                    onChanged: (value) =>
                        profileProvider.checkIsDataUpdatable(),
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldWidget(
                    controller: profileProvider.phoneController,
                    labelText: 'Phone Number',
                    hintText: 'Phone Number',
                    onChanged: (value) =>
                        profileProvider.checkIsDataUpdatable(),
                    textInputType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  SolidButton(
                      onTap: () {},
                      backgroundColor: profileProvider.isDataUpdatable
                          ? AppColor.primaryColor
                          : AppColor.disableColor,
                      child: const Text('Save Changes',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: TextSize.buttonText)))
                ],
              ),
            ),
          )
        ],
      );
}
