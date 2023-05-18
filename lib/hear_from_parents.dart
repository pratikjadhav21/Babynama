import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class HearFromParentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hear from Babynama Parents'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildCard(
            videoUrl: 'https://www.youtube.com/shorts/JVx2HMvNk54?feature=share',
            description: 'As a first time mother, I am always anxious, but doctor is always there. Must have for all first time moms. \n-Pranati, Mother of 3 month old baby',
          ),
          SizedBox(height: 16.0),
          _buildCard(
            videoUrl: 'https://www.youtube.com/shorts/b6oAvadGapY?feature=share',
            description: "It is a life changer. You can't go to offline doctor all the time, doctors here are very polite and very efficient. \n-Shipra, Mother of 3 month old baby",
          ),
          SizedBox(height: 16.0),
          _buildCard(
            videoUrl: 'https://youtu.be/DLgyEtzOGYo',
            description: "My baby had breathing issues, doctors here identified it and helped me calm down a lot. I get replies on my WhatsApp, very helpful. \n-Aabha, Mother of 4",
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required String videoUrl, required String description}) {
    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200.0,
            child: WebviewScaffold(
              url: videoUrl,
              withZoom: false,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(
                color: Colors.grey,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(description),
          ),
        ],
      ),
    );
  }
}
