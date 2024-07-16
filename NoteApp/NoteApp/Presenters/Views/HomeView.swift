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
        let formattedDate = date.formatted(date: .abbreviated, time: .omitted)
        let dayOfWeek = Calendar.current.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
        return (date, formattedDate, dayOfWeek)
    }
    var body: some View {
        NavigationStack{
            VStack{
                
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
    @ObservedObject var vm = VoiceViewModel()
    @Binding var isEmpty: Bool
    
    var date: String
    var day: String
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading){
                HStack {
                    VStack {
                        Text(day)
                            .font(.title)
                            .bold()
                        Text(date)
                    }
                    .foregroundColor(.black)
                    .padding()
                    
                    Spacer()
                }
                .background(.primaryBlue)
                .padding(-15)
                
                
                
                ScrollView(showsIndicators: false){
                    ForEach(vm.recordingsList, id: \.id) { recording in
                        
                        VStack {
                            HStack{
                                Image("Annoyed")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                
                                VStack (alignment: .leading){
                                    
                                    Slider(value: Binding<Double>(
                                                get: { vm.currentTime },
                                                set: { newValue in
                                                    vm.seek(to: TimeInterval(newValue))
                                                }
                                            ), in: 0.0...(vm.audioPlayer?.duration ?? 1.0)) // 
                                            .padding(.horizontal)
                                    
                                    HStack(spacing: 50){
                                        Spacer()
                                        Button{
                                            vm.deleteRecording(url:recording.fileURL)
                                        }label: {
                                            Image(systemName: "gobackward.10")
                                        }
                                        Button{
                                            if recording.isPlaying == true {
                                                vm.stopPlaying(url: recording.fileURL)
                                            }else{
                                                vm.startPlaying(url: recording.fileURL)
                                            }
                                        }label: {
//                                            Image(systemName: "play.fill")
                                            Image(systemName: recording.isPlaying ? "stop.fill" : "play.fill")
                                        }
                                        Button{
                                            
                                        }label: {
                                            Image(systemName: "goforward.10")
                                        }
                                        Spacer()
                                    }
                                    .font(.headline)
                                    .buttonStyle(.plain)
                                    
                                    Text("Recorded "+"\(recording.createdAt)")
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                        .padding(.top)
                                }
                            }
                            Divider()
                                .overlay(Color(.primaryBlue))
                        }
//                        Delete
//                        vm.deleteRecording(url:recording.fileURL)
                        
                    }
                    
                }.padding(.top, 10)
                
                
                Spacer()
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink {
                        TextOrVoiceView().toolbar(.hidden, for: .tabBar)
                    } label: {
                        HStack {
                            Image(systemName: "square.and.pencil")
                            Text("New Entry")
                            
                        }
                        .foregroundStyle(.black)
                        .padding()
                        .background(Capsule().foregroundStyle(.primaryBlue))
                        
                    }.buttonStyle(.plain)
                    
                }
            }
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .background(RoundedRectangle(cornerRadius: 20)
                    //            .stroke(lineWidth: 5)
            .foregroundStyle(.thickMaterial)
        )
        .frame(width: UIScreen.main.bounds.width - 50)
        .padding(.vertical)
        
        
    }
}
