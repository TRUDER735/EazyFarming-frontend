import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: Column(children: [
          ListTile(
            leading: const Icon(FontAwesomeIcons.user),
            title: const Text('Name'),
            subtitle: const Text('Mr Urombo'),
            trailing: TextButton(
                onPressed: () {
                  _showInputBottomSheet(context, "Name");
                },
                child: const Icon(
                  FontAwesomeIcons.pencil,
                  color: Color.fromARGB(255, 46, 42, 42),
                )),
          ),
          const ListTile(
            leading: Icon(FontAwesomeIcons.envelope),
            title: Text('Email'),
            subtitle: Text('urombo@gmail.com'),
          ),
          const ListTile(
            leading: Icon(FontAwesomeIcons.key),
            title: Text('password'),
            subtitle: Text('password'),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.phone),
            title: const Text('Phone number'),
            subtitle: const Text('0775334227'),
            trailing: TextButton(
                onPressed: () {
                  _showInputBottomSheet(context, "Phone number");
                },
                child: const Icon(
                  FontAwesomeIcons.pencil,
                  color: Color.fromARGB(255, 46, 42, 42),
                )),
          ),
        ]));
  }
}

Future _showInputBottomSheet(BuildContext context, String title) {
  return showModalBottomSheet<dynamic>(
    context: context,
    builder: (context) => Wrap(children: [
      Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Set $title",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              const TextField(),
              const SizedBox(
                height: 16.0,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Cancel"),
                  SizedBox(
                    width: 16.0,
                  ),
                  Text("Save")
                ],
              )
            ],
          ))
    ]),
  );
}
