//
//  CompleteSentence.swift
//  openai-3-api-call
//
//  Created by Jackson Wiese on 4/9/23.
//

//import OpenAISwift
import SwiftUI
import OpenAIKit

//            let version: String = "text-davinci-003"
//            let newString = "\(prompt) <|endoftext|>"
//            let arr: Array = newString.components(separatedBy: " ")

final class CompleteSent: ObservableObject {
    private var openai: OpenAI?
    func setup() {
        openai = OpenAI(Configuration(organizationId: "YOUR_ORG_ID_HERE", apiKey: "YOUR_API_KEY_HERE"))
    }
    
    func completeSentence (prompt: String) async -> String? {
        guard let openai = openai else {
            return nil
        }
        do  {
            let version: String = "text-davinci-003"
            let params = CompletionParameters(model: version, prompt: [prompt], maxTokens: 100, temperature: 0)
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


struct CompleteSentence: View {
    @ObservedObject var completeSent = CompleteSent()
    @State var requestText = ""
    @State var responseText = ""
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                if responseText.isEmpty {
                    Text("Type prompt to have it completed!")
                } else {
                    Text("\(responseText)")
                }
                Spacer()
                TextField("Type prompt here...", text: $requestText)
                    .padding()
                Button("Generate"){
                    if !requestText.isEmpty {
                        Task {
                            if let result = await completeSent.completeSentence(prompt: requestText) {
                                self.responseText = result
                            } else {
                                self.responseText = "Failed to generate completion"
                            }
                        }
                    }
                }
            }//end of VStack
            .navigationTitle("Complete Sentence")
            .onAppear {
                completeSent.setup()
            }
            .padding()
        }//end of NavView
    }
}


struct CompleteSentence_Previews: PreviewProvider {
    static var previews: some View {
        CompleteSentence()
    }
}
