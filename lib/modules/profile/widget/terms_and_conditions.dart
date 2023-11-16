import 'package:flutter/material.dart';
import 'package:fox/theme/styles/styles.dart';
import 'package:fox/utils/widget/appbar.dart';
import 'package:fox/utils/widget/no_scroll_behavior.dart';

class TermsAndConditions extends StatelessWidget {
  TermsAndConditions({Key? key}) : super(key: key);

  final textList = [
    {
      'type': 'text',
      'text':
          '''Shopify's ("Shopify", "we", "us") website(s) (our "Site" or "Sites") and related services are provided to you in accordance with with the following Terms of Use.
Shopify is a trading name of Ark Technologies Pty. Ltd., a company registered in Australia with  ACN 603272359 and principal place of business of 40/140 William Street, Melbourne 3000.

BY USING THIS SITE, YOU INDICATE YOUR UNCONDITIONAL ACCEPTANCE OF THESE TERMS OF USE (THE 'TERMS OF USE'). WE RESERVE THE RIGHT, IN OUR SOLE DISCRETION, TO UPDATE OR REVISE THESE TERMS OF USE. THE CONTINUED USE OF THE SITE FOLLOWING THE POSTING OF ANY CHANGES TO THE TERMS OF USE CONSTITUTES ACCEPTANCE OF THOSE CHANGES.''',
    },
    {
      'type': 'title',
      'text': '1 . Use of the Site',
    },
    {
      'type': 'text',
      'text':
          '''You may use the Site only in accordance with and subject to these Terms of Use and the Site's Privacy Policy (the 'Privacy Policy'). Once you complete and submit your registration, you have opted in to receive email communication from us. You may not use the Site for any purpose that is unlawful or prohibited by these Terms of Use, or to solicit the performance of any illegal activity or other activity which infringes the rights of Shopify or others. Notwithstanding any other rights or restrictions in these Terms of Use, you may not use this Site to: (a) transmit via or through the Site any information, data, text, images, files, links, or software except in connection with your authorized use of this Site or otherwise in response to specific requests for information by us; (b) introduce to the Site or any other computer or web site viruses, worms, Trojan horses and/or harmful code; (c) obtain unauthorized access to any computer system; (d) impersonate any other person, including but not limited to, a registered user of this Site or an employee of Shopify; (e) invade the privacy or violate any personal or proprietary right (including intellectual property rights) of any person or entity; (f) misrepresent the identity of a user or use a false e-mail address; (g) tamper with or obtain access to this Site or any component of this Site; (h) conduct fraudulent activities; or (i) collect or harvest information regarding other users of the Site for any reason whatsoever, including, without limitation, for sending such users unsolicited commercial e-mail.

You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account or password. You agree to immediately notify us in the event of any unauthorized use of your account or other breach of security.''',
    },
    {
      'type': 'title',
      'text': '2. Additional Terms and Conditions',
    },
    {
      'type': 'text',
      'text':
          '''Additional terms and conditions may apply to specific portions of the Site or your membership, which terms are made part of these Terms of Use by reference. You agree to abide by such other terms and conditions. If there is a conflict between these Terms of Use and the terms posted or emailed for, or applicable to, a specific portion of the Site the latter terms shall be in effect.

The following terms and conditions apply to the applicable features on the Site:''',
    },
    {
      'type': 'row',
      'title': '1.',
      'text':
          '''Credit Balances. Any credit balance (including a Reward balance) will be automatically applied to your next purchase of merchandise from the Site. To the extent your credits exceed the amount of your total purchase, such credit balance will remain in your account. If your account and/or membership is terminated for any reason, any credit balances in your account will be immediately cancelled. Account balances are determined by Shopify and such determination is final.''',
    },
    {
      'type': 'row',
      'title': '2.',
      'text':
          '''Online Gift Voucher. Shopify online gift voucher is honoured only on Shopify.com. Voucher is not exchangeable for cash. Voucher must be fully utilized when making payment. Any unutilized amount of this voucher will be forfeited and shall not be refundable. Voucher cannot be used for more than one transaction on Shopify.com. Shopify will not be responsible for the loss of the voucher.''',
    },
    {
      'type': 'row',
      'title': '3.',
      'text':
          '''We reserve the right to change our logistic provider/s at any time as needed to best fulfill customer orders.''',
    },
    {
      'type': 'title',
      'text': '3. Accuracy of Content; Limitations on Quantity',
    },
    {
      'type': 'text',
      'text':
          '''The information on this Site is believed to be complete and reliable; however, the information may contain typographical errors, pricing errors, and other errors or inaccuracies. Errors will be corrected as soon as practicable. We reserve the right to: (i) revoke any stated offer; (ii) correct any errors, inaccuracies or omission; and (iii) make changes to prices, content, promotion offers, product descriptions or specifications, or other information without obligation to issue any notice of such changes (including after an order has been submitted, acknowledged, shipped or received). We also reserve the right to limit quantities (including after an order has been submitted and/or acknowledged) and to revise, suspend or terminate an event, promotion at any time without notice. The inclusion of any products or services on this Site at a particular time does not guarantee that the products or services will be available.''',
    },
    {
      'type': 'title',
      'text': '4. Credit Card Payment',
    },
    {
      'type': 'text',
      'text':
          '''In a credit card transaction, you must use your own credit card. Shopify will not be liable for any credit card fraud. The liability to use a card fraudulently will be on the user and the onus to 'prove otherwise' shall be exclusively on the user.''',
    },
    {
      'type': 'title',
      'text': '5. Proprietary Rights',
    },
    {
      'type': 'text',
      'text':
          'You acknowledge and agree that the content, materials and other components (including but not limited to logos, graphics, button icons and page headers) available on the Site are the property of Shopify and are protected by copyrights, trademarks, service marks or other proprietary rights and laws. You agree not to sell, license, rent, modify, distributed, copy, reproduce, transmit, publicly display, publicly perform, publish, adapt, edit or create derivative works from content or materials on the Site. Use of the content and materials for any purpose not expressly permitted in these Terms of Use is prohibited.',
    },
    {
      'type': 'title',
      'text': '6. Links to Third-Party Web Sites; No Implied Endorsements',
    },
    {
      'type': 'text',
      'text':
          '''This Site may contain links to other websites on the Internet. You acknowledge that we have no control over such websites and that we are not responsible for the accuracy, content, legality or any other aspect of any linked websites. In no event shall any reference to any third party, third party website(s) or third party product(s) or service(s) be construed as an approval or endorsement by us of that third party, third party website(s) or of any product(s) or service(s) provided by a third party.''',
    },
    {
      'type': 'title',
      'text': '7. Indemnification',
    },
    {
      'type': 'text',
      'text':
          '''By using this Site, you agree to indemnify, hold harmless and defend Shopify, its parent, subsidiaries and affiliates, and their respective officers, directors, employees, successors, agents, subsidiaries, partners, contractors, vendors, manufacturers, distributors, representatives and affiliates from any claims, damages, losses, liabilities, and all costs and expenses of defense, including but not limited to, attorneys' fees, resulting directly or indirectly from a claim (including without limitation, claims made by third parties for infringement of intellectual property rights) by a third party that arises in connection with (i) your use or misuse of the Site; (ii) your breach of the Terms of Use; or (iii) your violation of any law or the rights of a third party. You agree to cooperate as fully as reasonably required in the defense of any claim. Shopify reserves the right to assume the exclusive defense and control of any matter otherwise subject to indemnification by you.''',
    },
    {
      'type': 'title',
      'text': '8. Product Quality',
    },
    {
      'type': 'text',
      'text':
          '''All goods undergo strict quality control procedures prior to shipment. We do not allow the shipment of flawed items or products of lower quality than the corresponding market standards for sale on the Website. Please note that items which are damaged or as a result of normal wear and tear; by accident; or through misuse will not be considered faulty, will not be accepted and will be sent back to the customer and/or a refund refused.

If an item you have ordered is not as described, is flawed or of a lower quality, you can return it to us within the prescribed return period. Please see our order and shipping page for instructions on how to place a return.

As a consumer, you have legal rights in relation to products that are faulty or not as described. Nothing in these Terms and Conditions will affect these legal rights.''',
    },
    {
      'type': 'title',
      'text': '9. Disclaimer of Warranty',
    },
    {
      'type': 'text',
      'text':
          '''THE SITE, ITS CONTENT AND ALL TEXTS, IMAGES, MERCHANDISE AND OTHER INFORMATION ON, ACCESSIBLE FROM OR AVAILABLE THROUGH THIS SITE ARE PROVIDED ON AN 'AS AVAILABLE' AND 'AS IS' BASIS WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT. SPECIFICALLY, BUT WITHOUT LIMITATION, Shopify DOES NOT WARRANT THAT: (i) THE INFORMATION AVAILABLE ON THIS SITE IS FREE OF ERRORS; (ii) THE FUNCTIONS CONTAINED ON THIS SITE WILL BE UNINTERRUPTED OR FREE OF ERRORS; (iii) DEFECTS WILL BE CORRECTED, OR (iv) THIS SITE OR THE SERVER(S) THAT MAKES IT AVAILABLE ARE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS.''',
    },
    {
      'type': 'title',
      'text': '10. Limitation of Liability',
    },
    {
      'type': 'text',
      'text':
          '''IN NO EVENT SHALL Shopify, ITS PARENT, SUBSIDIARIES OR AFFILIATES OR THEIR RESPECTIVE OFFICERS, DIRECTORS, EMPLOYEES, AGENTS, SUCCESSORS, SUBSIDIARIES, DIVISIONS, DISTRIBUTORS, SUPPLIERS, AFFILIATES OR THIRD PARTIES PROVIDING INFORMATION ON THIS SITE BE LIABLE TO ANY USER OF THE SITE OR ANY OTHER PERSON OR ENTITY FOR ANY DIRECT, INDIRECT, SPECIAL, INCIDENTAL, PUNITIVE, CONSEQUENTIAL OR EXEMPLARY DAMAGES (INCLUDING, BUT NOT LIMITED TO, DAMAGES FOR LOSS OF PROFITS, LOSS OF DATA OR LOSS OF USE) ARISING OUT OF THE USE OR INABILITY TO USE THE SITE OR ANY INFORMATION CONTAINED THEREON OR STORED OR MAINTAINED BY Shopify, WHETHER BASED UPON WARRANTY, CONTRACT, TORT, OR OTHERWISE, EVEN IF Shopify HAS BEEN ADVISED OF OR SHOULD HAVE KNOWN OF THE POSSIBILITY OF SUCH DAMAGES OR LOSSES. IN NO EVENT SHALL THE TOTAL LIABILITY OF Shopify, ITS PARENT, SUBSIDIARIES OR AFFILIATES OR THEIR RESPECTIVE OFFICERS, DIRECTORS, EMPLOYEES, AGENTS, SUCCESSORS, SUBSIDIARIES, DIVISIONS, DISTRIBUTORS, SUPPLIERS, AFFILIATES OR THIRD PARTIES PROVIDING INFORMATION ON THIS SITE TO YOU FOR ALL DAMAGES, LOSSES, AND CAUSES OF ACTION RESULTING FROM YOUR USE OF THIS SITE, WHETHER IN CONTRACT, TORT (INCLUDING, BUT NOT LIMITED TO, NEGLIGENCE) OR OTHERWISE, EXCEED THE AMOUNT YOU PAID TO Shopify IN CONNECTION WITH THE APPLICABLE EVENT, PROMOTION OR EVENT GIVING RISE TO SUCH LIABILITY. WITHOUT LIMITING THE FOREGOING, IN NO EVENT SHALL Shopify, ITS PARENT, SUBSIDIARIES OR AFFILIATES OR THEIR RESPECTIVE OFFICERS, DIRECTORS, EMPLOYEES, AGENTS, SUCCESSORS, SUBSIDIARIES, DIVISIONS, DISTRIBUTORS, SUPPLIERS, AFFILIATES OR THIRD PARTIES PROVIDING INFORMATION ON THIS SITE HAVE ANY LIABILITY FOR ANY DAMAGES OR LOSSES ARISING OUT OF OR OTHERWISE INCURRED IN CONNECTION WITH THE LOSS OF ANY DATA OR INFORMATION CONTAINED IN YOUR ACCOUNT OR OTHERWISE STORED BY OR ON BEHALF OF Shopify.

You hereby acknowledge that the preceding paragraph shall apply to all content, merchandise and services available through the Site. Because some countries do not allow limitations on implied warranties or the exclusion or limitation of certain damages, in such countries some or all of the above disclaimers or exclusions may not apply and liability will be limited to the fullest extent permitted by applicable law.''',
    },
    {
      'type': 'title',
      'text': '11. Unavailability of Site; Termination; Fraud',
    },
    {
      'type': 'text',
      'text':
          '''We may alter, suspend, or discontinue this Site in whole or in part, at any time and for any reason, without notice or cost. We may, in our sole discretion, terminate or suspend your use or access to all or part of the Site or your account or membership, for any reason, including without limitation, breach of these Terms of Use. If at any time, we notify you that your access to and /or use of the Site or your account is terminated, you must cease and desist from all such access and/or use immediately. We reserve the right to cancel, delay, refuse to ship, or recall from the shipper any order if fraud is suspected. In the event these Terms of Use or your membership or account are terminated, the restrictions regarding intellectual property matters, the representations and warranties, indemnities, and limitations of liabilities set forth herein (as well as any other of your obligations which by their nature should survive termination) will survive termination.''',
    },
    {
      'type': 'title',
      'text': '12. Deliveries',
    },
    {
      'type': 'text',
      'text':
          '''Our expected delivery time its our best effort estimation of the time required for you to receive your order after you have made a purchase. We cannot be held liable for any losses as a result of delivery occurring&nbsp;outside of our expected time frame and you are not released from your obligations as a customer or any other terms and conditions that may be relevant to your order should your order be delivered in a time frame other than our expected delivery time.&nbsp; If you are account needs to undergo security validation this will impact the delivery time. Shopify is&nbsp;not responsible for any delays caused by destination customs clearance issues.

We insure each purchase during the time it is in transit until it is delivered to your specified delivery address. We require a signature for any goods delivered, at which point responsibility for your purchased goods passes to you. If you have specified a recipient who is not you for delivery purposes (for example as a gift) then you accept that evidence of a signature by them (or at that delivery address) is evidence of delivery and fulfilment&nbsp;by Shopify, and transfer of responsibility in the same way. The goods are your responsibility from the time we deliver them to the address you gave us.

In certain circumstances our delivery partner may provide you with the following options when delivering your order: (a) signature release: opting out of the requirement to provide a signature on delivery; and/or (b) leave with neighbour: re-directing the delivery to a neighbour. You acknowledge and agree that we shall bear no responsibility or liability for any loss or damage that may result from delivering your order in accordance with your request.

By initiating a return, you agree to disclaim and assign exclusively to Shopify (and to the exclusion of any other party), any right to or interest in duty drawback you may have with respect to the returned item.''',
    },
    {
      'type': 'title',
      'text': '13. Copyright Infringement; Notice and Take Down Procedures',
    },
    {
      'type': 'text',
      'text':
          '''If you believe that any materials on this Site infringe your copyright, you may request that they be removed. This request must bear a signature (or electronic equivalent) of the copyright holder or an authorized representative and must: (a) identify the allegedly infringing materials; (b) indicate where on the Site the infringing materials are located; (c) provide your name and contact information; (d) state that you have a good faith belief that the materials are infringing; (e) state that the information in your claim is accurate; and (f) indicate that "under penalty of perjury" you are the lawful copyright owner or are authorized to act on the owner's behalf. Please email the copyright issue to legal@Shopify.com''',
    },
    {
      'type': 'title',
      'text': '14. Miscellaneous',
    },
    {
      'type': 'text',
      'text':
          '''Unless otherwise specified herein, these Terms of Use, together with the Privacy Policy, constitute the entire agreement between you and Shopify with respect to the Site and supersede all prior or contemporaneous communications and proposals (whether oral, written or electronic) between you and Shopify with respect to the Site. If any part of these Terms of Use is held invalid or unenforceable, that portion shall be construed in a manner consistent with applicable law to reflect, as nearly as possible, the original intentions of the parties, and the remaining portions shall remain in full force and effect. The failure of Shopify to act with respect to a breach by you or others does not waive Shopify's right to act with respect to subsequent or similar breaches. Shopify's failure to exercise or enforce any right or provision of these Terms of Use shall not constitute a waiver of such right or provision. The section headings contained in these Terms of Use are included for convenience only and shall not limit or otherwise affect the terms of these Terms of Use.

This agreement shall be governed by the law of the State of Victoria and the parties submit to the jurisdiction of the courts of that State.''',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Terms and Conditions",
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
