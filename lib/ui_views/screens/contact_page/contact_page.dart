import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:mabro/res/colors.dart';
import 'package:mabro/ui_views/commons/toolbar.dart';

import 'package:mabro/ui_views/screens/airtime_page/selected_mobile_carrier.dart';
import 'package:mabro/ui_views/screens/data_recharge_page/selected_data_recharge.dart';
import 'package:mabro/ui_views/screens/electricity_page/selected_electricity_page.dart';

class Contacts extends StatefulWidget {
  final String pageTitle;

  const Contacts({Key key, this.pageTitle}) : super(key: key);
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Contact> _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Contact contact;
  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);

      /// Get all fields (phones, emails, photo, job, etc) for a given contact
      contact = await FlutterContacts.getContact(contacts.first.id);

      setState(() => _contacts = contacts);
    }
  }

  // var _numbers = ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.primaryColor,
        appBar: TopBar(
          backgroundColorStart: ColorConstants.primaryColor,
          backgroundColorEnd: ColorConstants.secondaryColor,
          icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          title: 'My Contacts',
          onPressed: null,
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        body: _body());
  }

  Widget _body() {
    if (_permissionDenied)
      return Center(
        child: Text('Permission Denied',
            style: TextStyle(color: ColorConstants.whiteColor, fontSize: 16)),
      );
    if (_contacts == null)
      return Center(
          child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(ColorConstants.secondaryColor),
      ));
    return ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, i) {
          return Column(
            children: [
              ListTile(
                  leading: Container(
                    height: 37,
                    width: 37,
                    decoration: BoxDecoration(
                      color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    child: Icon(
                      Icons.person,
                      color: ColorConstants.whiteColor,
                    ),
                  ),
                  title: Text(_contacts[i].displayName,
                      style: TextStyle(
                          color: ColorConstants.whiteColor, fontSize: 14)),
                  // trailing: Text(contact.phones[0].number,
                  //     style: TextStyle(
                  //         color: ColorConstants.whiteColor, fontSize: 14)),
                  onTap: () async {
                    final fullContact =
                        await FlutterContacts.getContact(_contacts[i].id);

                    switch (widget.pageTitle) {
                      case 'airtime':
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => SelectedMobileCarrierPage(
                                contact: fullContact)));
                        break;
                      case 'electricity':
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => SelectedElectricitySubPage(
                                contact: fullContact)));
                        break;
                      case 'data':
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => SelectedDataRechargePage(
                                contact: fullContact)));
                        break;
                      case 'airtimeCash':
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => SelectedDataRechargePage(
                                contact: fullContact)));
                        break;
                    }
                  }),
              Divider(height: 0, color: ColorConstants.whiteLighterColor),
            ],
          );
        });
  }
}

class ContactPage extends StatelessWidget {
  final Contact contact;
  ContactPage(this.contact);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          title: Text(
              '${contact.phones.isNotEmpty ? contact.phones.first.number : '(none)'}')),
      body: Column(children: [
        Text('First name: ${contact.name.first}'),
        Text('Last name: ${contact.name.last}'),
        Text(
            'Phone number: ${contact.phones.isNotEmpty ? contact.phones.first.number : '(none)'}'),
        Text(
            'Email address: ${contact.emails.isNotEmpty ? contact.emails.first.address : '(none)'}'),
      ]));
}
