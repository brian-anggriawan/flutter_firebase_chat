import 'package:chat_flutter/pages/setting_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? signOutAction;
  const MyDrawer({super.key, this.signOutAction});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.message,
                  color: Theme.of(context).colorScheme.primary,
                  size: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  title: const Text('My Contacts'),
                  leading: const Icon(Icons.contact_mail),
                  iconColor: Theme.of(context).colorScheme.primary,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  title: const Text('Settings'),
                  leading: const Icon(Icons.settings),
                  iconColor: Theme.of(context).colorScheme.primary,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 40),
            child: ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              iconColor: Theme.of(context).colorScheme.primary,
              onTap: signOutAction,
            ),
          )
        ],
      ),
    );
  }
}
