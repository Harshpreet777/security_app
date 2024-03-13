import 'dart:developer';

import 'package:firebase_demo3/core/constants/image_constants.dart';
import 'package:firebase_demo3/core/constants/color_constants.dart';
import 'package:firebase_demo3/core/constants/string_constants.dart';
import 'package:firebase_demo3/core/models/user_model.dart';
import 'package:firebase_demo3/core/utils/validation_utils.dart';
import 'package:firebase_demo3/core/viewmodels/update_profile_view_model.dart';
import 'package:firebase_demo3/ui/views/base_view.dart';
import 'package:firebase_demo3/ui/widgets/common_elevated_button.dart';
import 'package:firebase_demo3/ui/widgets/common_stack_widget.dart';
import 'package:firebase_demo3/ui/widgets/common_textformfied.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// ignore: must_be_immutable
class UpdateProfileView extends StatelessWidget {
  UpdateProfileView({super.key, this.usersData});
  UserModel? usersData;
  late UpdateProfileViewModel model;
  Stream<UserModel> getData() async* {
    var data = await model.getData(usersData?.uid ?? '');
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<UpdateProfileViewModel>(onModelReady: (model) {
      this.model = model;
      SchedulerBinding.instance.addPostFrameCallback((_) async {});
    }, builder: (context, data, child) {
      return updateProfileViewModelMethod(context);
    });
  }

  updateProfileViewModelMethod(BuildContext context) {
    model.passController.text = usersData?.pass ?? '';
    return StreamBuilder<UserModel>(
        stream: getData(),
        builder: (context, snapshot) {
          UserModel? data = snapshot.data;
          return SafeArea(
              child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: Form(
              key: model.formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        padding: const EdgeInsets.all(10),
                        child: model.photo != null
                            ? CommonStackWidget(
                                onpress: () {
                                  _showPicker(context);
                                },
                                widget: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  child: Image.file(
                                    model.photo!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : data?.image.isNotEmpty ?? false
                                ? CommonStackWidget(
                                    onpress: () {
                                      _showPicker(context);
                                    },
                                    widget: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      child: Image.network(
                                        data?.image ?? '',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                                : Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color: ColorConstant.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(100))),
                                          width: 130,
                                          height: 130,
                                          child: Image.asset(
                                            usersData?.gender == 'Male'
                                                ? ImageConstant.maleIcon
                                                : ImageConstant.femaleIcon,
                                            fit: BoxFit.fill,
                                          )),
                                      Positioned(
                                        bottom: -10,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: ColorConstant.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(50))),
                                          child: IconButton(
                                              onPressed: () {
                                                _showPicker(context);
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color: ColorConstant.black,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormFieldWidget(
                      hintText: data?.name ?? '',
                      textInputType: TextInputType.name,
                      label: StringConstants.name,
                      controller: model.nameController,
                      validator: (value) {
                        return Validations.isNameValid(value.toString());
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormFieldWidget(
                      hintText: data?.email ?? '',
                      textInputType: TextInputType.emailAddress,
                      label: StringConstants.email,
                      controller: model.emailController,
                      validator: (value) {
                        return Validations.isEmailValid(value.toString());
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormFieldWidget(
                      hintText: data?.phoneNo ?? '',
                      textInputType: TextInputType.number,
                      label: StringConstants.phoneNo,
                      controller: model.phoneNoController,
                      validator: (value) {
                        return Validations.isPhoneNoValid(value.toString());
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            StringConstants.gender,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        addRadioButton(0, 'Male'),
                        addRadioButton(1, 'Female'),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButtonWidget(
                      btnText: StringConstants.update,
                      onpress: () {
                        model.emailController.text =
                            model.emailController.text.isEmpty
                                ? data?.email ?? ''
                                : model.emailController.text;
                        model.phoneNoController.text =
                            model.phoneNoController.text.isEmpty
                                ? data?.phoneNo ?? ''
                                : model.phoneNoController.text;
                        model.nameController.text =
                            model.nameController.text.isEmpty
                                ? data?.name ?? ''
                                : model.nameController.text;
                        model.updateProfile(usersData?.uid ?? '');
                      },
                    )
                  ]),
                ),
              ),
            ),
          ));
        });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SizedBox(
              child: Wrap(
                children: [
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: Text(StringConstants.gallery),
                      onTap: () {
                        model.imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text(StringConstants.camera),
                    onTap: () {
                      model.imgFromCamera();

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  addRadioButton(int index, String title) {
    return Flexible(
      child: RadioListTile(
        activeColor: ColorConstant.black,
        title: Text(title),
        value: model.gender[index],
        groupValue: usersData?.gender,
        onChanged: (value) {
          log(value.toString());
          usersData?.gender = value;

          model.changeGender(usersData?.gender ?? '');
        },
      ),
    );
  }
}
