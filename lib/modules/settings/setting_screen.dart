import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/styles/colors.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {

        LoginModel? model = AppCubit.get(context).profileModel;
        nameController.text = model!.data.name!;
        emailController.text = model.data.email!;
        phoneController.text = model.data.phone!;
        return ConditionalBuilder(
          condition: AppCubit.get(context).profileModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [

                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    onFieldSubmitted: (value) {},
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'name must be not empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person_pin_sharp)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value) {},
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'email must be not empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email_rounded)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    onFieldSubmitted: (value) {},
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'phone must be not empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone',
                        prefixIcon: Icon(Icons.phone)),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 250,
                    child: MaterialButton(
                      onPressed: () {
                        signOut(context);
                      },

                      color: defaultColor,
                      child: const Text(
                          'LOG OUT',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: MaterialButton(
                      onPressed: ()
                      {
                        if(formkey.currentState!.validate())
                        {
                          AppCubit.get(context).getUpdate(
                              token : token,
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text
                          );
                        }
                      },

                      color: defaultColor,
                      child: const Text(

                          'UPDATE',
                          style: TextStyle(color: Colors.white)),
                    ),
                  )

                ],
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
