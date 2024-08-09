import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isDarkTheme = false;

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkTheme ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: const Color(0xFF6A1B9A),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'URL_DE_LA_IMAGEN_DEL_USUARIO',
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name Surname',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'john.doe@example.com',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PREFERENCES',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildSettingOption('Language', Icons.language,
                      trailing: const Text('English')),
                  _buildSettingOption(
                    'Dark Mode',
                    Icons.brightness_6,
                    trailing: Switch(
                      value: _isDarkTheme,
                      onChanged: (val) {
                        _toggleTheme();
                      },
                    ),
                  ),
                  _buildSettingOption(
                    'Only Download via Wi-Fi',
                    Icons.wifi,
                    trailing: Switch(
                      value: true,
                      onChanged: (val) {},
                    ),
                  ),
                  _buildSettingOption(
                      'Play in Background', Icons.play_circle_fill),
                  const SizedBox(height: 30),
                  const Text(
                    'CONTENT',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildSettingOption('Favorites', Icons.favorite),
                  _buildSettingOption('Downloads', Icons.download),
                  const SizedBox(height: 30),
                  const Text(
                    'ACCOUNT',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildSettingOption('Help', Icons.help_outline),
                  _buildSettingOption('Audio Guide', Icons.volume_up),
                  _buildSettingOption('Logout', Icons.logout),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingOption(String title, IconData icon, {Widget? trailing}) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      leading: Icon(icon, color: Colors.purple),
      title: Text(title),
      trailing:
          trailing ?? const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: () {
      },
    );
  }
}
