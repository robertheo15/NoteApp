//
//  QuoteView.swift
//  Endxiety
//
//  Created by Ali Haidar on 11/07/24.
//

import SwiftUI

struct QuoteView: View {
    var body: some View {
        NavigationLink {
            MainView().navigationTitle(LocalizedStringKey("My Notes"))
        }label: {
            VStack(spacing:20){
                Spacer()
                Text("\"\nRemember, licking doorknobs is illegal on other planets.\"")
                    .italic()
                    .font(.title3)
                Text("- Spongebob -")
                    .bold()
                
                Spacer()
                Text("Tap anywhere to exit")
                
            }.foregroundStyle(.primary).padding(50)
        }.navigationBarBackButtonHidden()
            
    }
}

#Preview {
    QuoteView()
}
