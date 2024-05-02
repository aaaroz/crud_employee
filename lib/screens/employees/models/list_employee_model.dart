import 'dart:io';

import 'package:crud_employee/components/text_field_component.dart';
import 'package:crud_employee/constant/routes_navigation.dart';
import 'package:crud_employee/models/employees_models.dart';
import 'package:crud_employee/services/auth_services.dart';
import 'package:crud_employee/services/employee_services.dart';
import 'package:crud_employee/theme/color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ListEmployeeModels extends ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _provinceController = TextEditingController();
  TextEditingController get provinceController => _provinceController;

  final TextEditingController _cityController = TextEditingController();
  TextEditingController get cityController => _cityController;

  final TextEditingController _positionController = TextEditingController();
  TextEditingController get positionController => _positionController;

  final TextEditingController _religionController = TextEditingController();
  TextEditingController get religionController => _religionController;

  String? _imageUrl;

  XFile? _image;
  get image => _image;

  EmployeeModels? _employeeList;
  EmployeeModels? get employeeList => _employeeList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    _nameController.dispose();
    _provinceController.dispose();
    _cityController.dispose();
    _positionController.dispose();
    _religionController.dispose();
    super.dispose();
  }

  Future<void> isAuthorized({required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    try {
      bool isAuth = await AuthServices().isAuthorized();

      if (context.mounted && !isAuth) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesNavigation.splashView,
          (route) => false,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getEmployeeList() async {
    try {
      _employeeList = await EmployeeServices().getEmployees();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> deleteEmployee(
      {required BuildContext context, required String id}) async {
    try {
      await EmployeeServices().deleteEmployee(id: id);

      getEmployeeList();

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: negative,
          content: const Text("Data deleted successfully!"),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> pickImage(
      {bool isCamera = true, required StateSetter setState}) async {
    final result = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);

    if (result != null) {
      setState(() {
        _image = result;
        notifyListeners();
      });
    }
  }

  Future<void> createData(
      {required BuildContext context, required StateSetter setState}) async {
    FormData formData = FormData.fromMap({
      'name': _nameController.text,
      'province': _provinceController.text,
      'city': _cityController.text,
      'position': _positionController.text,
      'religion': _religionController.text,
      'image': await MultipartFile.fromFile(_image!.path)
    });

    setState(() {
      _isLoading = true;
      notifyListeners();
    });
    try {
      await EmployeeServices().createEmployee(formData: formData);

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primary500,
          content: const Text("Data created successfully!"),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> updateData(
      {required BuildContext context,
      required String id,
      required StateSetter setState}) async {
    FormData formData = FormData.fromMap({
      'name': _nameController.text,
      'province': _provinceController.text,
      'city': _cityController.text,
      'position': _positionController.text,
      'religion': _religionController.text,
      'image': _image == null
          ? _imageUrl
          : await MultipartFile.fromFile(_image!.path)
    });

    setState(() {
      _isLoading = true;
      notifyListeners();
    });
    try {
      await EmployeeServices().updateEmployee(formData: formData, id: id);

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primary500,
          content: const Text("Data updated successfully!"),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void clearResult() {
    _image = null;
    notifyListeners();
  }

  void showBottomSheet({required BuildContext context, String? id}) async {
    if (id != null) {
      final employee = await EmployeeServices().getEmployeeById(id: id);
      final existingData = employee['data'];

      _nameController.text = existingData['name'];
      _provinceController.text = existingData['province'];
      _cityController.text = existingData['city'];
      _positionController.text = existingData['position'];
      _religionController.text = existingData['religion'];
      _imageUrl = existingData['image_url'];
    }
    if (!context.mounted) return;

    showModalBottomSheet(
      backgroundColor: Colors.white,
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Container(
          padding: EdgeInsets.only(
            top: 30,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 50,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            _nameController.clear();
                            _provinceController.clear();
                            _cityController.clear();
                            _positionController.clear();
                            _religionController.clear();
                            clearResult();
                            _isLoading = false;
                            notifyListeners();
                          });
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close))),
                Text(
                  'Form Data Employees',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: primary500),
                ),
                const SizedBox(height: 30),
                TextFieldComponent(
                  controller: _nameController,
                  hintText: "Name",
                  hinstStyle: const TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldComponent(
                  controller: _positionController,
                  hintText: "Position",
                  hinstStyle: const TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldComponent(
                  controller: _cityController,
                  hintText: "City",
                  hinstStyle: const TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldComponent(
                  controller: _provinceController,
                  hintText: "Province",
                  hinstStyle: const TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldComponent(
                  controller: _religionController,
                  hintText: "Religion",
                  hinstStyle: const TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                          child: const Text(
                            'Choose Image',
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            pickImage(isCamera: false, setState: setState);
                          }),
                      IconButton(
                        onPressed: () {
                          pickImage(setState: setState);
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          color: primary500,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                id == null
                    ? _image != null
                        ? SizedBox(
                            height: 80,
                            child: Image.file(
                              File(_image!.path),
                            ),
                          )
                        : const Text('Select Image First!')
                    : SizedBox(
                        height: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(children: [
                              const Text('Old Image'),
                              SizedBox(
                                height: 80,
                                child: Image.network(_imageUrl!),
                              )
                            ]),
                            Column(
                              children: [
                                const Text('New Image'),
                                SizedBox(
                                  height: 80,
                                  width: 120,
                                  child: _image != null
                                      ? Image.file(File(_image!.path))
                                      : const Text(
                                          'Choose new image to change old image.'),
                                )
                              ],
                            )
                          ],
                        )),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (id == null) {
                        if (!_isLoading) {
                          await createData(context: context, setState: setState)
                              .then((_) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: primary500,
                                      content: const Text(
                                          "Data created successfully!"),
                                    ),
                                  ));
                        }
                      }
                      if (id != null) {
                        if (!_isLoading) {
                          if (!context.mounted) return;
                          await updateData(
                                  context: context, id: id, setState: setState)
                              .then((_) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: primary500,
                                      content: const Text(
                                          "Data updated successfully!"),
                                    ),
                                  ));
                        }
                      }

                      _nameController.clear();
                      _provinceController.clear();
                      _cityController.clear();
                      _positionController.clear();
                      _religionController.clear();
                      clearResult();
                      _isLoading = false;
                      notifyListeners();

                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                      getEmployeeList();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              id == null ? "Create Data" : "Update Data",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
