import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:window_to_front/window_to_front.dart';

import 'github_oauth_credentials.dart';
import 'src/github_login.dart';
import 'src/github_summary.dart';

void main() {
  runApp(const GithubClientApp());
}

class GithubClientApp extends StatelessWidget {
  const GithubClientApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Client',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const GithubClientHomePage(title: 'Github Client'),
    );
  }
}

class GithubClientHomePage extends StatelessWidget {
  const GithubClientHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return GithubLoginWidget(
      builder: (context, httpClient) {
        WindowToFront.activate();
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: GitHubSummary(
            gitHub: _getGithub(httpClient.credentials.accessToken)
            ),
        );
      },
      githubClientId: githubClientId,
      githubClientSecret: githubClientSecret,
      githubScopes: githubScopes,
    );
  }

  GitHub _getGithub(String accessToken) {
    return GitHub(auth: Authentication.withToken(accessToken));
  }

}