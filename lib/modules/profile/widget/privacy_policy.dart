import 'package:flutter/material.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({Key? key}) : super(key: key);

  final textList = [
    {
      'type': 'title',
      'text': 'About Shopify',
    },
    {
      'type': 'text',
      'text':
          '''This website is owned and run Ark Technologies Pty. Ltd. (“Company”). We are committed to protecting your privacy and prepared this Privacy Policy bound by the Australian Privacy Principles and the Privacy Act 1988 (Cth) to describe to you our practices regarding the personal information we collect from users of those websites that link to this Privacy Policy (each, a “Site” and collectively, the “Sites”)and the services we offer (the “Services”). ''',
    },
    {
      'type': 'title',
      'text': 'Questions; Contacting Company; Reporting Violations.',
    },
    {
      'type': 'text',
      'text':
          '''If you have any questions or concerns or complaints about our Privacy Policy or our data collection or processing practices, or if you want to report any security violations to us, please mail us at the following address:

Ark Technologies Pty. Ltd.

40/140 Williams Street
Melbourne
Victoria 3000
ACN: 603 272 359

A Note about Children. We do not intentionally gather personal information from
visitors who are under the age of 13. If a child under 13 submits personal information to the Company and we learn that the personal information is the information of a child under 13, we will attempt to delete the information as soon as possible. If you believe that we might have any personal information from a child under 13, please contact us at: legal@Shopify.com ''',
    },
    {
      'type': 'title',
      'text': 'Personal Data',
    },
    {
      'type': 'text',
      'text':
          '''In this Privacy Policy, 'Personal Data' refers to any data, whether true or not, about an individual who can be identified (a) from that data; or (b) from that data and other information to which we have or are likely to have access, including data in our records as may be updated from time to time.

Examples of such 'Personal Data' you may provide to us include your name, passport or other identification number, telephone numbers, mailing address, email address, network data and any other information relating to any individuals which you have provided us in any forms you may have submitted to us, or via other forms of interaction with you.''',
    },
    {
      'type': 'title',
      'text': 'Information Collected',
    },
    {
      'type': 'text',
      'text':
          '''We collect 'Personal Data', directly from you, or from publicly available sources or through our website in the following ways:''',
    },
    {
      'type': 'row',
      'title': '1.',
      'text':
          'when you submit a form for registering as a customer on our website or any other forms relating to any of our Products and Services',
    },
    {
      'type': 'row',
      'title': '2.',
      'text':
          'when you interact with our member relations team, for example, via telephone calls, letters, face-to-face meetings and emails',
    },
    {
      'type': 'row',
      'title': '3.',
      'text':
          'when you use some of our services, for example, websites and apps including establishing any online accounts with us',
    },
    {
      'type': 'row',
      'title': '4.',
      'text':
          'when you request that we contact you, be included in an email or other mailing list',
    },
    {
      'type': 'row',
      'title': '5.',
      'text':
          'when you respond to our promotions, initiatives or to any request for additional Personal Data',
    },
    {
      'type': 'row',
      'title': '6.',
      'text':
          'when you are contacted by, and respond to, our marketing representatives and customer service team',
    },
    {
      'type': 'row',
      'title': '7.',
      'text':
          'when we receive references from business partners and third parties, for example, where you have been referred by them',
    },
    {
      'type': 'row',
      'title': '8.',
      'text':
          '''when you submit your 'Personal Data' to us for any other reasons.''',
    },
    {
      'type': 'text',
      'text':
          '''When you browse our website, you generally do so anonymously. However, please note of other features present. Please see paragraph 4 below on the understanding of Cookies.''',
    },
    {
      'type': 'row',
      'title': '1.',
      'text':
          'In order to fully access this Site, you must first complete the registration process. During the registration process, we collect personal information such as your name and email address. Once you have completed and submitted your registration, you will be opted in to receive email communication from us.',
    },
    {
      'type': 'row',
      'title': '2.',
      'text':
          'We also collect personal information when you choose to use certain features of the Site, such as making purchases or electing to receive text messages about upcoming events or promotions. When you choose to use these additional features, we require you to provide additional personal information such as your phone number, billing and shipping addresses and credit card information, and we may request additional personal information such as your shopping preferences and demographics.',
    },
    {
      'type': 'row',
      'title': '3.',
      'text':
          'In addition, through the Site, we automatically gather certain information about the use of the Site, such as how frequently certain areas of the Site are visited, including through the use of cookies, web beacons and other technologies. Most browsers can be set to prevent cookies or to notify you when one is being placed. However, cookies are necessary to access the Site.',
    },
    {
      'type': 'row',
      'title': '4.',
      'text':
          'The Site also makes use of a technology designed to enhance your browsing experience and to provide aggregate non-personally identifiable information about the use of the Site to us. Information on deleting or controlling cookies is available at www.AboutCookies.org. Please note that by deleting our cookies or disabling future cookies you may not be able to access certain areas or features of our site.',
    },
    {
      'type': 'title',
      'text': 'How We Use Your Information',
    },
    {
      'type': 'text',
      'text':
          '''We will not share or disclose your information to anyone except as described in this Privacy Policy.

We use personally identifiable information in order to give you a more enjoyable, convenient shopping experience and to help us identify and/or provide information, products or services that may be of interest to you. We collect, may use and disclose your 'Personal Data' for the following purposes:''',
    },
    {
      'type': 'row',
      'title': '1.',
      'text': 'responding to your queries and requests;',
    },
    {
      'type': 'row',
      'title': '2.',
      'text': 'fulfilling your order(s);',
    },
    {
      'type': 'row',
      'title': '3.',
      'text': 'tracking email invitations you send;',
    },
    {
      'type': 'row',
      'title': '4.',
      'text':
          'managing administrative and business operations and complying with internal policies and procedures;',
    },
    {
      'type': 'row',
      'title': '5.',
      'text':
          'facilitating business asset transactions (which may extend to any mergers, acquisitions or asset sales, and transfers made as part of an insolvency or bankruptcy proceeding) involving any of the all or part of our business or as part of a corporate reorganization, stock sale or other change in control;',
    },
    {
      'type': 'row',
      'title': '6.',
      'text':
          '''matching any 'Personal Data' held which relates to you for any of the purposes listed herein;''',
    },
    {
      'type': 'row',
      'title': '7.',
      'text':
          'resolving complaints and handling requests and enquiries through your personalised profile of your shopping history;',
    },
    {
      'type': 'row',
      'title': '8.',
      'text':
          'preventing, detecting and investigating crime and analysing and managing commercial risks;',
    },
    {
      'type': 'row',
      'title': '9.',
      'text': 'providing media announcements and responses;',
    },
    {
      'type': 'row',
      'title': '10.',
      'text':
          'monitoring or recording phone calls and customer-facing interactions for quality assurance, employee training and performance evaluation and identity verification purposes;',
    },
    {
      'type': 'row',
      'title': '11.',
      'text': 'organising promotional events;',
    },
    {
      'type': 'row',
      'title': '12.',
      'text':
          'legal purposes (including but not limited to obtaining legal advice and dispute resolution);',
    },
    {
      'type': 'row',
      'title': '13.',
      'text':
          'conducting investigations relating to disputes, billing or fraud;',
    },
    {
      'type': 'row',
      'title': '14.',
      'text':
          'providing postal mailing list (consisting of customer names and postal mailing addresses, but not email addresses) to other companies whose products we believe may be of interest to you. In order to determine those products that we believe may be of interest to you, the information from you and your order may be combined with other personally identifiable information (such as demographic information and past purchase history) available from our records and other sources.',
    },
    {
      'type': 'row',
      'title': '15.',
      'text':
          'meeting or complying with any applicable rules, laws, regulations, codes of practice or guidelines issued by any legal or regulatory bodies (including but not limited to responding to regulatory complaints, disclosing to regulatory bodies and conducting audit checks, due diligence and investigations); and purposes which are reasonably related to the aforesaid.',
    },
    {
      'type': 'text',
      'text':
          '''Plus, we may share personally identifiable or other information with our parent, subsidiaries, divisions, and affiliates.

We reserve the right to disclose information in order to comply with a subpoena, court order, administrative or governmental order, or any other requirement of law, or when we, in our sole discretion, believe it is necessary in order to protect our rights or the rights of others, to prevent harm to individuals or property, to fight fraud and credit risk reduction.

You will receive notice when your personally identifiable information might be provided to any third party for any reason other than as set forth in this Privacy Policy, and you will have an opportunity to request that we do not share such information.

We use non-personally identifiable information in the aggregate, so that we can improve the Site and for business and administrative purposes. We may also use or share with third parties for any purpose aggregated data that contains no personally identifiable information.''',
    },
    {
      'type': 'title',
      'text': 'How We Protect Your Information',
    },
    {
      'type': 'text',
      'text':
          '''We are committed to protecting the information we receive from you. We follow reasonable technical and management practices to help protect the confidentiality, security and integrity of data stored in our system. While no computer system is completely secure, we believe the measures we have implemented reduce the likelihood of security problems to a level appropriate to the type of data involved.

The Site encrypts your credit card number and other personal information using secure socket layer (SSL) technology to provide for the secure transmission of the information from your PC to our servers. In addition, only those employees and third parties who need access to your information in order to perform their duties are allowed such access.''',
    },
    {
      'type': 'title',
      'text': 'Disclosure of Personal Data',
    },
    {
      'type': 'text',
      'text':
          '''We will take reasonable steps to protect your 'Personal Data' against unauthorised disclosure. Subject to the provisions of any applicable law, your 'Personal Data' may be disclosed, for the purposes listed above (where applicable), to the following:''',
    },
    {
      'type': 'row',
      'title': '1.',
      'text':
          'Related corporations and employees to provide content, Products and Services to you, address your questions and requests in relation to your customer accounts, subscription and billing or order arrangements with us as well as our Products and Services, to activate, deactivate, install, maintain and operate our systems and/or services;',
    },
    {
      'type': 'row',
      'title': '2.',
      'text':
          'companies providing services relating to insurance and consultancy;',
    },
    {
      'type': 'row',
      'title': '3.',
      'text':
          'agents, contractors or third party service providers who provide us operational services, such as courier services, telecommunications, information technology, payment, printing, billing, payroll, processing, technical services, training, market research, call centre, security or other services:',
    },
    {
      'type': 'row',
      'title': '4.',
      'text':
          'vendors or third party service providers in connection with marketing promotions and services offered by us or our preferred partners;',
    },
    {
      'type': 'row',
      'title': '5.',
      'text':
          'any business partner, investor, assignee or transferee (actual or prospective) to facilitate business asset transactions (which may extend to any merger, acquisition or asset sale) involving any of the',
    },
    {
      'type': 'row',
      'title': '6.',
      'text': 'our professional advisers such as auditors and lawyers;',
    },
    {
      'type': 'row',
      'title': '7.',
      'text':
          'relevant government regulators, statutory boards or authorities or law enforcement agencies to comply with any laws, rules, guidelines and regulations or schemes imposed by any governmental authority; and',
    },
    {
      'type': 'row',
      'title': '8.',
      'text':
          '''any other party to whom you authorise us to disclose your 'Personal Data' to.''',
    },
    {
      'type': 'title',
      'text': 'Quality of Personal Information',
    },
    {
      'type': 'text',
      'text': '''We will take reasonable steps to:''',
    },
    {
      'type': 'row',
      'title': '1.',
      'text':
          'make sure that the personal information we collect, use or disclose is accurate, complete and up to date;',
    },
    {
      'type': 'row',
      'title': '2.',
      'text':
          'protect your personal information from misuse, loss, unauthorised access, modification or disclosure both physically and through computer security methods; and',
    },
    {
      'type': 'row',
      'title': '3.',
      'text':
          'destroy or permanently de-identify personal information if it is no longer needed for its purpose of collection.',
    },
    {
      'type': 'title',
      'text':
          'Accessing and Updating Your Personal Information and Preferences',
    },
    {
      'type': 'text',
      'text':
          '''If you are a registered user, you may access and update your registration information and your preferences to receive email or other communications by updating the required information in the “Account Details" section of the website.

We will take commercially reasonable steps to implement your opt-out requests promptly, but you may still receive communications from us for up to ten business days while we process your request.

While we make efforts to accommodate requests to restrict our use of your information, we reserve the right to delete all or any portion of customer information if we are not able to reasonably accommodate a requested restriction.''',
    },
    {
      'type': 'title',
      'text': 'Privacy Policy Changes',
    },
    {
      'type': 'text',
      'text':
          '''If we decide to change our Privacy Policy for the Site, we will post the revised Privacy Policy here so that you will always know what information we gather, how we might use that information and whether we may disclose it to anyone. Your continued use of the Site indicates your assent to the Privacy Policy as posted.''',
    },
    {
      'type': 'title',
      'text': 'Governing Law',
    },
    {
      'type': 'text',
      'text':
          '''This agreement shall be governed by the law of the State of Victoria and the parties submit to the jurisdiction of the courts of that State.''',
    },
    {
      'type': 'row',
      'title': '',
      'text': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Privacy Policy",
      ),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: NoScrollBehavior(),
          child: ListView.builder(
            itemCount: textList.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index < textList.length) {
                var textInfo = textList[index];
                if (textInfo['type'] == 'title') {
                  return Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      top: 16,
                    ),
                    child: Text(
                      textInfo['text'] ?? '',
                      style: AppTextStyle.BlackBold16,
                    ),
                  );
                } else if (textInfo['type'] == 'text') {
                  return Container(
                    margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
                    child: Text(
                      textInfo['text'] ?? '',
                      style: AppTextStyle.Black16,
                    ),
                  );
                } else {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerRight,
                        width: 20,
                        margin: const EdgeInsets.only(left: 16, top: 5),
                        child: Text(
                          textInfo['title'] ?? '',
                          style: AppTextStyle.Black16,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin:
                              const EdgeInsets.only(left: 5, top: 5, right: 16),
                          child: Text(
                            textInfo['text'] ?? '',
                            style: AppTextStyle.Black16,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              } else {
                return const SizedBox(
                  height: 60,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
