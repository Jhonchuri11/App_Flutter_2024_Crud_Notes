import 'package:app13/student.dart';
import 'package:app13/student_database.dart';
import 'package:app13/student_details_view.dart';
import 'package:flutter/material.dart';

class StudentView extends StatefulWidget {
  const StudentView({super.key});

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  StudentDatabase studentDatabase = StudentDatabase.instance;

  List<StudentModel> students = [];

  @override
  void initState() {
    refreshNotes();
    super.initState();
  }

  @override
  dispose() {
    //close the database
    studentDatabase.close();
    super.dispose();
  }

  ///Gets all the notes from the database and updates the state
  refreshNotes() {
    studentDatabase.readAll().then((value) {
      setState(() {
        students = value;
      });
    });
  }

  ///Navigates to the NoteDetailsView and refreshes the notes after the navigation
  goToStudentDetailsView({int? id}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentDetailsView(noteId: id)),
    );
    refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Center(
        child: students.isEmpty
            ? const Text(
                'No Student yet',
                style: TextStyle(color: Colors.white),
              )
            : ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return GestureDetector(
                    onTap: () => goToStudentDetailsView(id: student.id),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                student.createdTime.toString().split(' ')[0],
                              ),
                              Text(
                                student.name,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToStudentDetailsView,
        tooltip: 'Create Student',
        child: const Icon(Icons.add),
      ),
    );
  }
}
