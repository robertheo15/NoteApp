//
//  MainView.swift
//  Endxiety
//
//  Created by Ali Haidar on 11/07/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
       
        TabView{
            HomeView()
                .tabItem {
                    Label("My Notes", systemImage: "note.text")
                }
            TrendsView()
                .tabItem {
                    Label("Trends", systemImage: "chart.bar.xaxis")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }.navigationBarBackButtonHidden()
          
    }
}

#Preview {
    MainView()
}
