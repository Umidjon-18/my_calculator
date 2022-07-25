import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal:50, vertical: 100),
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/main_images/about_bg.jpg'), fit: BoxFit.cover)
        ),
        child: Column(
          
          children: [
            const Image(image: AssetImage('assets/images/main_images/cal_logo.png'),height: 150,),
            const SizedBox(height: 30),
            const Text('Best Calculator version 1.1.0', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20),
            const Text('Creator: Umidjon Yoqubov', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10),
            const Text('contact', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email_outlined, color: Colors.grey[300],size: 20,),
                const SizedBox(width: 10),
                const Text('umidjonxomidjonovich@gmail.com', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
