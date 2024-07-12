//
//  EmotionRateView.swift
//  Endxiety
//
//  Created by Ali Haidar on 11/07/24.
//

import SwiftUI

struct EmotionRateView: View {
    @State private var selectedEmojiIndex: Int?
    
    var arrEmoji = ["😄", "😊","😐","😕","☹️"]
    
    var body: some View {
        VStack{
            Text("What emoji that best describes you now?")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            HStack{
                ForEach (0..<arrEmoji.count, id: \.self) { index in
                    Button(action: {
                        self.selectedEmojiIndex = index
                    }) {
                        Text(arrEmoji[index])
                            .padding()
                            .background(self.selectedEmojiIndex == index ? Circle().fill(Color.blue) : Circle().fill(Color.gray))
                    }
                }
            }
        }
        .padding()
        .toolbar {
            NavigationLink{
                QuoteView()
            }label: {
                Image(systemName: "checkmark")
            }
        }
    }
}

#Preview {
    EmotionRateView()
}
