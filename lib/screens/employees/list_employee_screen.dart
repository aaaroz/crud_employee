import 'package:crud_employee/extensions/capitalize.dart';
import 'package:crud_employee/screens/employees/models/list_employee_model.dart';
import 'package:crud_employee/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListEmployee extends StatefulWidget {
  const ListEmployee({super.key});

  @override
  State<ListEmployee> createState() => _ListEmployeeState();
}

class _ListEmployeeState extends State<ListEmployee> {
  @override
  void initState() {
    Provider.of<ListEmployeeModels>(context, listen: false)
        .isAuthorized(context: context);
    Provider.of<ListEmployeeModels>(context, listen: false).getEmployeeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primary500,
        title: const Row(
          children: [
            Image(
              image: AssetImage('images/vector.png'),
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10),
            Text(
              "List of Employees",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<ListEmployeeModels>(
          builder: (context, listEmployeeModels, child) {
            final employeeList = listEmployeeModels.employeeList;
            final employee = employeeList?.response;
            return listEmployeeModels.employeeList == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: employee!.length,
                    itemBuilder: (context, index) => Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Name :",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Text(
                                  'Province :',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  'City :',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  'Religion :',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  'Position :',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        listEmployeeModels.showBottomSheet(
                                            context: context,
                                            id: employee[index].id);
                                      },
                                      icon: const Icon(Icons.edit),
                                      color: primary500,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        listEmployeeModels.deleteEmployee(
                                            context: context,
                                            id: employee[index].id);
                                      },
                                      icon: const Icon(Icons.delete),
                                      color: negative,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  employee[index].name.capitalize(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  employee[index].province.capitalize(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  employee[index].city.capitalize(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  employee[index].religion.capitalize(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  employee[index].position.capitalize(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 135,
                              width: 135,
                              child: Image(
                                image: NetworkImage(employee[index].imageUrl),
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: primary800,
        backgroundColor: primary500,
        onPressed: () => Provider.of<ListEmployeeModels>(context, listen: false)
            .showBottomSheet(context: context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
