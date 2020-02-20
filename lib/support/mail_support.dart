import 'package:MyStudyBuddy2/support/my_form.dart';
import 'package:flutter/material.dart';
//import 'package:validators/validators.dart' as validators;
//import 'package:flutter_mailer/flutter_mailer.dart';

/* final MailOptions mailOptions = MailOptions(
      body: 'a long body for the email <br> with a subset of HTML',
      subject: 'the Email Subject',
      recipients: ['example@example.com'],
      isHTML: true,
      bccRecipients: ['other@example.com'],
      ccRecipients: ['third@example.com'],
      attachments: [ 'path/to/image.png', ],
    );

    await FlutterMailer.send(mailOptions);*/

class MailSupport extends StatefulWidget {
  @override
  MailSupportState createState() => MailSupportState();
}

class MailSupportState extends State<MailSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("E-Mail Support"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context, false),
      ),
       ),
       body: MyForm(),
       );
  }
}


