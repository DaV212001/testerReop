import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../util/app_constants.dart';

class PaymentScreen extends StatefulWidget {
  final String url;

  const PaymentScreen({super.key, required this.url});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isLoading=true;
  bool error = false;
  String errorText = "";
  bool loadedAferError = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          automaticallyImplyLeading: false,
        ),
        body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri.uri(Uri.parse(widget.url),
                  ),
                ),
                onProgressChanged: (InAppWebViewController controller, int progress) {
                  controller.getCertificate();
                  if(progress>=100){
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                onReceivedError:(InAppWebViewController controller, WebResourceRequest request, WebResourceError err) {
                  if(!loadedAferError){
                    print("ERRORRRRRRRRRRRRRRRR");
                    controller.loadUrl(urlRequest: URLRequest(
                      url: WebUri.uri(Uri.parse(widget.url),
                      ),
                    ),);
                    setState(() {
                      loadedAferError = true;
                    });
                  }

                },
                // onReceivedHttpError: (InAppWebViewController controller, WebResourceRequest request, WebResourceResponse err) {
                //   setState(() {
                //     isLoading = false;
                //     error = true;
                //   });
                //   errorText = err.reasonPhrase!;
                //
                // },
                onReceivedServerTrustAuthRequest: (InAppWebViewController controller, URLAuthenticationChallenge challenge) async  {

                  SslError? sslCertificateError = SslError();
                  sslCertificateError = challenge.protectionSpace.sslError;
                  return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
                  // if(sslCertificateError != null){
                  //     setState(() {
                  //       isLoading = false;
                  //       error = true;
                  //     });
                  //     errorText = sslCertificateError.message!;
                  // }
                  print("SSSSSSSSSSSSSSSSSSLLLLLLLLLLLLLLLLLL==================ERRORRRRRRRRRRRRRRRR");
                  controller.loadUrl(urlRequest: URLRequest(
                    url: WebUri.uri(Uri.parse(widget.url),
                    ),
                  ),);
                },
              ),
              if(isLoading)
                const Center(
                  child: CircularProgressIndicator(color: AppConstants.primary,),
                ),
              if(error)
                Container(
                  color: Theme.of(context).colorScheme.primary,
                  child: Center(
                    child: Text(errorText),
                  ),
                )
            ]
        )
    );
  }
}
