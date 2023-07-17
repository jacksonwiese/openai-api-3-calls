//
//  SentimentAnalysis.swift
//  openai-3-api-call
//
//  Created by Jackson Wiese on 4/9/23.
//

import SwiftUI
import OpenAIKit

final class SentAnalysis: ObservableObject {
    private var openai: OpenAI?
    func setup() {
        //Add ORG ID and API key here
        openai = OpenAI(Configuration(organizationId: "org-WmlbvfDdUkg0Q9jW0GAmWvwH", apiKey: "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"))
    }
    
    func sentAnalysis (prompt: String) async -> String? {
        guard let openai = openai else {
            return nil
        }
        do  {
            
            let version: String = "text-davinci-003"
            let message = "How am I feeling in the following message: \(prompt)"
            let params = CompletionParameters(model: version, prompt: [message], maxTokens: 100, temperature: 0)
            let result = try await openai.generateCompletion(parameters: params)
            let data = result.choices.first?.text
            return data
        }
        catch {
            print(String(describing: error))
            return nil
        }
    }
}

struct SentimentAnalysis: View {
    @ObservedObject var sentAnalysis = SentAnalysis()
    @State var requestText = ""
    @State var responseText = ""
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                if responseText.isEmpty {
                    Text("Type prompt to tell whether the prompt is positive or negative!")
                } else {
                    Text("\(responseText)")
                }
                Spacer()
                TextField("Type prompt here...", text: $requestText)
                    .padding()
                Button("Generate"){
                    if !requestText.isEmpty {
                        Task {
                            if let result = await sentAnalysis.sentAnalysis(prompt: requestText) {
                                self.responseText = result
                            } else {
                                self.responseText = "Failed to generate completion"
                            }
                        }
                    }
                }
            }//end of VStack
            .navigationTitle("Sentiment Analysis")
            .onAppear {
                sentAnalysis.setup()
            }
            .padding()
        }//end of NavView
    }
}

struct SentimentAnalysis_Previews: PreviewProvider {
    static var previews: some View {
        SentimentAnalysis()
    }
}
