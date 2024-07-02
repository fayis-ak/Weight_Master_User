import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weigh_master/Data/Model/feedback_model.dart';
import 'package:weigh_master/Data/db_service.dart';

// class FeedbackModel {
//   final String name;
//   final String email;
//   final String experience;
//   final String mood;
//   final DateTime date;

//   FeedbackModel({
//     required this.name,
//     required this.email,
//     required this.experience,
//     required this.mood,
//     required this.date,
//   });
// }

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  String _selectedMood = '😊';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 100, 250, 250),
        title: const Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Full name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text('Full Name'),
                    hintText: 'Enter Full Name',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                // email
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text('Email'),
                    hintText: 'Enter Email',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const Text('How was your experience?'),
                Wrap(
                  children: [
                    _buildMoodEmoji('😢'),
                    _buildMoodEmoji('😕'),
                    _buildMoodEmoji('😐'),
                    _buildMoodEmoji('😊'),
                    _buildMoodEmoji('😄'),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Choose Your Experience',
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    controller: _experienceController,
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your experience';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Suggest anything we can improve..',
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),
                      contentPadding: EdgeInsets.all(8.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitFeedback();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text('Submit Feedback'),
                ),

                const SizedBox(height: 16.0),
                const Text(
                  'Recent Feedback',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 100,
                  child:
                      Consumer<DBService>(builder: (context, dbService, child) {
                    return StreamBuilder(
                        stream: dbService.getAllFeedBack().asStream(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasData) {
                            final data = dbService.listOFFeedback;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dbService.listOFFeedback.length,
                              itemBuilder: (context, index) {
                                // FeedbackModel feedback = feedbacks[index];
                                return Container(
                                  margin: const EdgeInsets.only(right: 8.0),
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        data[index].suggession,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                          '${data[index].username} • ${data[index].email} • ${data[index].experience}'),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Text("Loading...");
                          }
                        });
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoodEmoji(String emoji) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMood = emoji;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedMood == emoji ? Colors.blue : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  void _submitFeedback() {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String experience = _experienceController.text.trim();
    if (name.isNotEmpty && email.isNotEmpty && experience.isNotEmpty) {
      // setState(() {
      DBService().addFeedBack(FeedbackModel(
          email: email,
          experience: _selectedMood,
          suggession: experience,
          uid: FirebaseAuth.instance.currentUser!.uid,
          username: name));

      _nameController.clear();
      _emailController.clear();
      _experienceController.clear();
      _selectedMood = '😊';
      // });
    }
  }
}
