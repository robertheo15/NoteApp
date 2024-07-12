//
//  HomeView.swift
//  Endxiety
//
//  Created by Ali Haidar on 11/07/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var isEmpty = true
    let dates = (0..<8).map { index in
        let date = Date().addingTimeInterval(-Double(index) * 24 * 60 * 60)
        let formattedDate = date.formatted(date: .numeric, time: .omitted).components(separatedBy: "/").first ?? "" // Get only the day
        let dayOfWeek = Calendar.current.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1] // Get the day of the week
        return (date, formattedDate, dayOfWeek)
    }
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("July 2024")
                        .bold()
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "calendar")
                            .foregroundStyle(.white)
                            .padding()
                            .background(Circle())
                    }
                    
                }
                .frame(width: UIScreen.main.bounds.width - 50)
                
                ScrollView(.horizontal){
                    HStack{
                        ForEach(dates, id: \.0) { (date, formattedDate, dayOfWeek) in
                            NoteCalendarView(isEmpty: $isEmpty, date: formattedDate, day: dayOfWeek)
                                .containerRelativeFrame(.horizontal, count: 1, spacing: 16)
                                
                        }
                    }
                    .scrollTargetLayout()
                }
                .defaultScrollAnchor(.trailing)
                .contentMargins(.horizontal, 20, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                
            }
            .navigationTitle(LocalizedStringKey("My Notes"))
        }
    }
}

#Preview {
    HomeView()
}

struct NoteCalendarView: View {
    
    @Binding var isEmpty: Bool
    
    var date: String
    var day: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text(date)
                .font(.title)
                .bold()
            Text(day)
            
            Divider()
            
            Spacer()
            
            if isEmpty{
                HStack {
                    Spacer()
                    NavigationLink {
                        TextOrVoiceView().toolbar(.hidden, for: .tabBar)
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }

                    Spacer()
                }
                
            }else{
                VStack{
                    
                }
            }
            
            
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20)
            .stroke(lineWidth: 5)
            .foregroundStyle(.regularMaterial)
        )
        .frame(width: UIScreen.main.bounds.width - 50)
        .padding(.vertical)
    }
}
