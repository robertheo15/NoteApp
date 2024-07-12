//
//  NoteView.swift
//  Endxiety
//
//  Created by Ali Haidar on 11/07/24.
//

import SwiftUI

struct NoteView: View {
    @State private var notes: NSMutableAttributedString = NSMutableAttributedString(string: "")
    
    @FocusState var keyboardFocused
    var body: some View {
        ZStack{
            VStack {
                TextView(attributedText: $notes, allowsEditingTextAttributes: true, font: .systemFont(ofSize: 32))
//                TextEditor(text: $notes)
                    .toolbar{
                        ToolbarItem(placement: .keyboard){
                            HStack(spacing: 15){
                                Text("Title")
                                
                                Divider()
                                
                                Text("Heading")
                                Divider()
                                Button(action: {
                                    applyBoldFormatting()
                                }) {
                                    Image(systemName: "bold")
                                }
                                Divider()
                                Button(action: {
                                    applyUnderlineFormatting()
                                }) {
                                    Image(systemName: "underline")
                                }
                                Divider()
                                Button(action: {
                                    applyItalicFormatting()
                                }) {
                                    Image(systemName: "italic")
                                }
                            }
                        }
                    }
                    .focused($keyboardFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            keyboardFocused = true
                        }
                    }
                    .padding(.top, 50)
                
                Text(.init(notes))
                
                Button{
                    
                } label: {
                    Text("I don't know where to start")
                        .font(.footnote)
                        .padding()
                        .background(Capsule().foregroundStyle(.thickMaterial))
                }.padding(.top)
                
                Spacer()
            }
        }.toolbar {
            NavigationLink{
                EmotionRateView()
            }label: {
                Image(systemName: "checkmark")
            }
        }
    }
    
    
    private func applyBoldFormatting() {
        let selectedText = notes // Replace with logic to get selected text range
        let newText = "**\(selectedText)**"
        // Replace selected text with newText or update notes
        notes = NSMutableAttributedString(string: newText)
    }
    
    // Function to apply Markdown-like underline formatting
    private func applyUnderlineFormatting() {
        let selectedText = notes // Replace with logic to get selected text range
        let newText = "__\(selectedText)__"
        // Replace selected text with newText or update notes
        notes = NSMutableAttributedString(string: newText)
    }
    
    // Function to apply Markdown-like italic formatting
    private func applyItalicFormatting() {
        let selectedText = notes // Replace with logic to get selected text range
        let newText = "*\(selectedText)*"
        // Replace selected text with newText or update notes
        notes = NSMutableAttributedString(string: newText)
    }
}

#Preview {
    NoteView()
}
