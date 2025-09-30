import 'package:Cricbites/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:Cricbites/core/constants/app_colors.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool isLoading = true;
  bool showAppBar = false;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            showAppBar = widget.key == const ValueKey("newWindow");
            setState(() => isLoading = true);
          },
          onPageFinished: (_) => setState(() => isLoading = false),
           onUrlChange: (nextUrl){
             if(nextUrl.url!.contains(widget.url)){
                setState(() {
                  showAppBar = true;
                });
              }else{
               setState(() {
                 showAppBar = false;
               });
             }
          },
          onNavigationRequest: (request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<bool> _handleBackPress() async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBackPress,
      child: SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: AppColors.black,
          appBar: showAppBar
              ? CommonAppBar(
            titleText: "",
            showBackButton: true,
          )
              : null,
          body: Stack(
            children: [
              WebViewWidget(
                key: ValueKey(widget.url),
                controller: _controller,
              ),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(color: AppColors.white),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
