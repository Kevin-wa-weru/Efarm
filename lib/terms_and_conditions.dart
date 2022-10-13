import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({Key? key}) : super(key: key);

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  bool agreed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.053333333,
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 60,
                width: 60,
                color: Colors.transparent,
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.128,
            ),
            const Text(
              'Terms & Conditions',
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
                      child: const Text(
                        '1. Introduction',
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
                        'Welcome to Lycus Technology Inc Company These Terms of Service (“Terms”, “Terms of Service”) govern your use of our website located at lycustechnologies.com (together or individually “Service”) operated by Lycus Technology Inc.Our Privacy Policy also governs your use of our Service and explains how we collect, safeguard and disclose information that results from your use of our web pages.Your agreement with us includes these Terms and our Privacy Policy (“Agreements”). You acknowledge that you have read and understood Agreements, and agree to be bound of them.If you do not agree with (or cannot comply with) Agreements, then you may not use the Service, but please let us know by emailing at info@lycustechnologies.com so we can try to find a solution. These Terms apply to all visitors, users and others who wish to access or use Service.',
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
                        '2. Communications',
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
                        'By using our Service, you agree to subscribe to newsletters, marketing or promotional materials and other information we may send. However, you may opt out of receiving any, or all, of these communications from us by following the unsubscribe link or by emailing at info@lycustechnologies.com.',
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
                        '3. Contests, Sweepstakes and Promotions',
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
                        'Any contests, sweepstakes or other promotions (collectively, “Promotions”) made available through Service may be governed by rules that are separate from these Terms of Service. If you participate in any Promotions, please review the applicable rules as well as our Privacy Policy. If the rules for a Promotion conflict with these Terms of Service, Promotion rules will apply.',
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
                        '4. Content',
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
                        'Our Service allows you to post, link, store, share and otherwise make available certain information, text, graphics, videos, or other material (“Content”). You are responsible for Content that you post on or through Service, including its legality, reliability, and appropriateness.By posting Content on or through Service, You represent and warrant that: (i) Content is yours (you own it) and/or you have the right to use it and the right to grant us the rights and license as provided in these Terms, and (ii) that the posting of your Content on or through Service does not violate the privacy rights, publicity rights, copyrights, contract rights or any other rights of any person or entity. We reserve the right to terminate the account of anyone found to be infringing on a copyright.You retain any and all of your rights to any Content you submit, post or display on or through Service and you are responsible for protecting those rights. We take no responsibility and assume no liability for Content you or any third party posts on or through Service. However, by posting Content using Service you grant us the right and license to use, modify, publicly perform, publicly display, reproduce, and distribute such Content on and through Service. You agree that this license includes the right for us to make your Content available to other users of Service, who may also use your Content subject to these Terms.Lycus Technology Inc has the right but not the obligation to monitor and edit all Content provided by users.In addition, Content found on or through this Service are the property of Lycus Technology Inc or used with permission. You may not distribute, modify, transmit, reuse, download, repost, copy, or use said Content, whether in whole or in part, for commercial purposes or for personal gain, without express advance written permission from us.',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            height: 2,
                            fontSize: 14),
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.033251,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.073333333,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          agreed = !agreed;
                        });
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: agreed == true
                                ? const Color(0xFF3EA334)
                                : Colors.transparent,
                            border: Border.all(
                              color: Colors.black87,
                              width: agreed == true ? 0.5 : 2,
                            )),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'I agree with the',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Terms and Condition',
                        style: TextStyle(
                            color: Color(0xFF39B54A),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.0615763,
                      width: MediaQuery.of(context).size.width * 0.8933333,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              colors: [
                                Color(0xFF7CD956),
                                Color(0xFF3EA334),
                              ])),
                      child: const Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
