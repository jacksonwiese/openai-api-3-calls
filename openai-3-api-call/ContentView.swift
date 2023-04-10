//
//  ContentView.swift
//  openai-3-api-call
//
//  Created by Jackson Wiese on 4/9/23.
//


import OpenAIKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DallESearch()
                .tabItem {
                    Image(systemName: "photo")
                    Text("Image Gen")
                }
            CompleteSentence()
                .tabItem {
                    Image(systemName: "text.redaction")
                    Text("Sentence")
                }
            SentimentAnalysis()
                .tabItem{
                    Image(systemName: "face.smiling.inverse")
                    Text("Sentiment")
                }
        }//end of TabView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
