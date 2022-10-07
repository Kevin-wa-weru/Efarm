import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.128,
            ),
            const Text(
              'Privacy Policy',
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontFamily: 'PublicSans',
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.023891625,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.133333333,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.77066666,
                        child: const Text(
                          'PRIVACY POLICY MODEL FOR CHIMBO&E-FARM MOBILE APPLICATIONS',
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w700,
                              height: 2,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.053333333,
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.77066666,
                      child: const Text(
                        'This privacy policy governs your use of the software application CHIMBO/E-FARM (“Application”) for mobile devices that was created by Lycus Technologies Inc.The Application is E-farm application is the platform that will allow farmers to automate agricultural procedures, particularly marketing, such as displaying products, searching for and meeting with clients (vendors and final consumers).The main goal of an app goal is to create a well-organized digital market for agricultural products in East Africa.Chimbo application is the platform created as a smart, sustainable digital solution that offers well-established, accredited, transparent and secure sales process pipelines for the real estate industry. Our custom features and solutions leverage the best out of existing modern technology in support of the buyers’ and sellers’ requirements and needs.',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            height: 2,
                            fontSize: 14),
                      )),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.133333333,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.77066666,
                        child: const Text(
                          'Does the Application collect precise real time location information of the device?',
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w700,
                              height: 2,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.053333333,
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.77066666,
                      child: const Text(
                        'This Application does not collect precise information about the location of your mobile device.',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            height: 2,
                            fontSize: 14),
                      )),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.133333333,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.77066666,
                        child: const Text(
                          'Do third parties see and/or have access to information obtained by the Application?',
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w700,
                              height: 2,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.053333333,
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.77066666,
                      child: const Text(
                        'Yes. We will share your information with third parties only in the ways that are described in this privacy statement.We may disclose User Provided and Automatically Collected Information:as required by law, such as to comply with a subpoena, or similar legal process;when we believe in good faith that disclosure is necessary to protect our rights, protect your safety or the safety of others, investigate fraud, or respond to a government request;with our trusted services providers who work on our behalf, do not have an independent use of the information we disclose to them, and have agreed to adhere to the rules set forth in this privacy statement.If   Lycus Technologies Inc.is involved in a merger, acquisition, or sale of all or a portion of its assets, you will be notified via email and/or a prominent notice on our Web site of any change in ownership or uses of this information, as well as any choices you may have regarding this information.to advertisers and third party advertising networks and analytics companies as described in the section below',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            height: 2,
                            fontSize: 14),
                      )),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.133333333,
                      ),
                      child: const Text(
                        'Automatic Data Collection and Advertising',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w700,
                            height: 2,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.053333333,
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.77066666,
                      child: const Text(
                        'We may work with analytics companies to help us understand how the Application is being used, such as the frequency and duration of usage. We work with advertisers and third party advertising networks, who need to know how you interact with advertising provided in the Application which helps us keep the cost of the Application low. Advertisers and advertising networks use some of the information collected by the Application, including, but not limited to, the unique identification ID of your mobile device and your mobile telephone number. To protect the anonymity of this information, we use an encryption technology to help ensure that these third parties can’t identify you personally. These third parties may also obtain anonymous information about other applications you’ve downloaded to your mobile device, the mobile websites you visit, your non-precise location information (e.g., your zip code), and other non- precise location information in order to help analyze and serve anonymous targeted advertising on the Application and elsewhere. We may also share encrypted versions of information you have provided in order to enable our partners to append other available information about you for analysis or advertising related use. If you’d like to opt-out from third party use of this type of information to help serve targeted advertising, please visit the section entitled “Opt-out” below. ',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            height: 2,
                            fontSize: 14),
                      )),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.133333333,
                      ),
                      child: const Text(
                        'What are my opt-out rights?',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w700,
                            height: 2,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.053333333,
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.77066666,
                      child: const Text(
                        'There are multiple opt-out options for users of this Application:Opt-out of all information collection by uninstalling the Application: You can stop all collection of information by the Application easily by uninstalling the Application. You may use the standard uninstall processes as may be available as part of your mobile device or via the mobile application marketplace or network. You can also request to opt-out via email, at info@lycustechnologies.com.Opt-out from the use of information to serve targeted advertising by advertisers and/or third party network advertisers: you may at any time opt-out from further allowing us to have access to your location data by disabling the location tracking feature on the app ',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            height: 2,
                            fontSize: 14),
                      )),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.133333333,
                      ),
                      child: const Text(
                        'Data Retention Policy, Managing Your Information',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w700,
                            height: 2,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.053333333,
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.77066666,
                      child: const Text(
                        'We will retain User Provided data for as long as you use the Application and for a reasonable time thereafter. We will retain Automatically Collected information for up to 24 months and thereafter may store it in aggregate. If you’d like us to delete User Provided Data that you have provided via the Application, please contact us at info@lycustechnologies.com and we will respond in a reasonable time. Please note that some or all of the User Provided Data may be required in order for the Application to function properly.',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            height: 2,
                            fontSize: 14),
                      )),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.133333333,
                      ),
                      child: const Text(
                        'Children',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w700,
                            height: 2,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.053333333,
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.77066666,
                      child: const Text(
                        'We do not use the Application to knowingly solicit data from or market to children under the age of 13. If a parent or guardian becomes aware that his or her child has provided us with information without their consent, he or she should contact us at info@lycustechnologies.com. We will delete such information from our files within a reasonable time.',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            height: 2,
                            fontSize: 14),
                      )),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.133333333,
                      ),
                      child: const Text(
                        'Security',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w700,
                            height: 2,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.053333333,
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.77066666,
                      child: const Text(
                        'We are concerned about safeguarding the confidentiality of your information. We provide physical, electronic, and procedural safeguards to protect information we process and maintain. For example, we limit access to this information to authorized employees and contractors who need to know that information in order to operate, develop or improve our Application. Please be aware that, although we endeavor provide reasonable security for information we process and maintain, no security system can prevent all potential security breaches.',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            height: 2,
                            fontSize: 14),
                      )),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.133333333,
                      ),
                      child: const Text(
                        'Changes',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w700,
                            height: 2,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.053333333,
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.77066666,
                      child: const Text(
                        'This Privacy Policy may be updated from time to time for any reason. We will notify you of any changes to our Privacy Policy by posting the new Privacy Policy here and informing you via email or text message. You are advised to consult this Privacy Policy regularly for any changes, as continued use is deemed approval of all changes. You can check the history of this policy by clicking here.',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            height: 2,
                            fontSize: 14),
                      )),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.133333333,
                      ),
                      child: const Text(
                        'Your Consent',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w700,
                            height: 2,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.053333333,
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.77066666,
                      child: const Text(
                        'By using the Application, you are consenting to our processing of your information as set forth in this Privacy Policy now and as amended by us. "Processing,” means using cookies on a computer/hand held device or using or touching information in any way, including, but not limited to, collecting, storing, deleting, using, combining and disclosing information, all of which activities will take place in the United States. If you reside outside the United States your information will be transferred, processed and stored there under United States privacy standards. ',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            height: 2,
                            fontSize: 14),
                      )),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.133333333,
                      ),
                      child: const Text(
                        'Contact us',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w700,
                            height: 2,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.053333333,
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.77066666,
                      child: const Text(
                        'If you have any questions regarding privacy while using the Application, or have questions about our practices, please contact us via email at info@lycustechnologies.com.',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            height: 2,
                            fontSize: 14),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
