import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_application_1/check.dart';
import 'firebase_options.dart';
import 'package:flutter_application_1/buttom_bar.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(SettingsApp());
}

class SettingsApp extends StatefulWidget {
  @override
  State<SettingsApp> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsApp> {
  bool _isDarkMode = false; // State to manage dark mode toggle

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currensee',
      theme: _isDarkMode
          ? ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.black,
              // accentColor: Colors.teal,
            )
          : ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.blue,
              // accentColor: Colors.orange,
            ),
      home: MyHomePage(
        title: 'Currensee / Setting',
        isDarkMode: _isDarkMode,
        onThemeChanged: (bool value) {
          setState(() {
            _isDarkMode = value;
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const MyHomePage({
    required this.title,
    required this.isDarkMode,
    required this.onThemeChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      isDarkMode: isDarkMode,
      onThemeChanged: onThemeChanged,
    );
  }
}

class SettingsPage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const SettingsPage({
    required this.isDarkMode,
    required this.onThemeChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blue, 
        leading: IconButton(onPressed: (){ Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) =>
                            ButtomBar()));
  },
        icon: Icon(Icons.arrow_back)),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0), // Add top padding
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Edit Profile'),
              onTap: () {
                // Navigate to Edit Profile Page
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: isDarkMode,
              onChanged: onThemeChanged, // Notify parent to change theme
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              value: 'English', // Default language
              onChanged: (String? newValue) {
                // Handle language change logic
              },
              items: <String>['English', 'Urdu', 'French']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Handle logout logic
            },
          ),
        ],
      ),
    );
  }
}