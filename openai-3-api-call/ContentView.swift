//
//  ContentView.swift
//  openai-3-api-call
//
//  Created by Jackson Wiese on 4/9/23.
//


import SwiftUI

struct ContentView: View {
    
    @State private var isPresentingNewView = false
    
    var body: some View {
        NavigationStack{
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

        }//end of navigation view
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
