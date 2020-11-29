import 'package:flutter/material.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final NavigationService navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ayuda",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text("Preguntas Frecuentes"),
              onTap: () {
                navigationService.navigateTo(Routes.FAQRoute);
              },
            ),
            ListTile(
              leading: Icon(Icons.volume_off),
              title: Text("Politicas de Privacidad"),
              onTap: () {
                navigationService.navigateTo(Routes.PolicyRoute);
              },
            ),
            ListTile(
              leading: Icon(Icons.data_usage),
              title: Text("Condiciones de Uso"),
              onTap: () {
                navigationService.navigateTo(Routes.ConditionsRoute);
              },
            ),
            Spacer(
              flex: 1,
            ),
            Divider(
              height: 30.0,
              thickness: 1.0,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                          children: [
                            TextSpan(
                                text: " Pamiksa",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "  Implementar con la biblioteca",
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ]))
                ])
          ],
        ),
      ),
    );
  }
}
