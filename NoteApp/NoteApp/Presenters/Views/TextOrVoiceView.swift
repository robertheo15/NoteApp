//
//  TextOrVoiceView.swift
//  Endxiety
//
//  Created by Ali Haidar on 11/07/24.
//

import SwiftUI

struct TextOrVoiceView: View {
    var body: some View {
        VStack{
            NavigationLink{
                NoteView()
            } label: {
                Image(systemName: "note.text")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 25, height: UIScreen.main.bounds.height / 4)
                    .background(RoundedRectangle(cornerRadius: 12))
            }
            
                Text("or")
                .font(.title)
            
            NavigationLink{
                VoiceRecordView()
            } label: {
                Image(systemName: "mic")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 25, height: UIScreen.main.bounds.height / 4)
                    .background(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

#Preview {
    TextOrVoiceView()
}
