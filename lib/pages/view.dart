import 'package:crop/pages/home.dart';
import 'package:crop/services/auth.dart';
import 'package:crop/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future _getProfile() async {
    Auth auth = Auth();
    dynamic user = await auth.getUser(Provider.of<UserProvider>(context).email);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: FutureBuilder(
            future: _getProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                dynamic user = snapshot.data;
                if (user == null) {
                  return const Center(child: Text('User not found'));
                }
                return Column(children: [
                  ProfileTile(
                    icon: FontAwesomeIcons.user,
                    text: user['first_name'],
                    heading: 'Name',
                    editable: true,
                  ),
                  ProfileTile(
                    icon: FontAwesomeIcons.user,
                    text: user['last_name'],
                    heading: 'last name',
                    editable: true,
                  ),
                  ProfileTile(
                      icon: FontAwesomeIcons.envelope,
                      text: user['email'],
                      heading: 'Email',
                      editable: false),
                  const ProfileTile(
                    icon: FontAwesomeIcons.key,
                    text: 'Password',
                    heading: 'password',
                    editable: true,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                    onPressed: () async {
                      await Provider.of<UserProvider>(context, listen: false)
                          .logOut();
                      Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    },
                    child: const Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.doorOpen,
                          color: Color.fromARGB(255, 46, 42, 42),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Color.fromARGB(255, 46, 42, 42),
                          ),
                        )
                      ],
                    ),
                  )
                ]);
              }
            }));
  }
}

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final String heading;
  final bool editable;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.text,
    required this.editable,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(heading),
      subtitle: Text(text),
      trailing: TextButton(
          onPressed: () {
            _showInputBottomSheet(context, heading);
          },
          child: editable
              ? const Icon(
                  FontAwesomeIcons.pencil,
                  color: Color.fromARGB(255, 46, 42, 42),
                )
              : const Text("")),
    );
  }
}

Future _showInputBottomSheet(BuildContext context, String title) {
  final TextEditingController controller = TextEditingController();

  return showModalBottomSheet<dynamic>(
    context: context,
    builder: (context) => SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Set $title",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                  child: TextField(
                controller: controller,
              )),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                  const SizedBox(
                    width: 16.0,
                  ),
                  TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: const Text('Save'))
                ],
              )
            ],
          )),
    ),
  );
}
