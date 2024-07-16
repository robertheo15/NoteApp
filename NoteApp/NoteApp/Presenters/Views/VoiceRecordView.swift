//
//  VoiceRecordView.swift
//  Endxiety
//
//  Created by Ali Haidar on 11/07/24.
//

import SwiftUI

struct VoiceRecordView: View {
    @ObservedObject var vm = VoiceViewModel()
    
    @State private var animationScale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            ZStack{
                
                Circle()
                    .scaleEffect(animationScale)
                    .opacity(vm.isRecording ? 1.0 : 0.5)
                
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            .background(.tertiary)
            .foregroundStyle(.tertiary)
            Spacer()
            
            Text(vm.timer)
                .bold()
                .font(.largeTitle)
            
            HStack(spacing: 50){
                Button{
                    
                }label: {
                    Image(systemName: "gobackward.10")
                }
                Button{
                    
                }label: {
                    Image(systemName: "play.fill")
                }
                Button{
                    
                }label: {
                    Image(systemName: "goforward.10")
                }
            }.font(.largeTitle)
                .padding(.vertical,50)
            
            Divider()
            
            Button{
                if vm.isRecording {
                    vm.stopRecording()
                }else{
                    vm.startRecording()
                }
            }label: {
                Image(systemName: vm.isRecording ? "pause.fill" : "circle.fill")
                    .resizable()
                    .frame(width: 65, height: 65)
                
            }
            
        }
        .onChange(of: vm.audioInputLevel) {
                withAnimation {
                    animationScale = CGFloat(1.0 + (vm.audioInputLevel * 2.0)) // adjust the scaling factor as needed
                }
            }
        .toolbar {
            NavigationLink{
                EmotionRateView()
            }label: {
                Image(systemName: "checkmark")
                    .onTapGesture {
                        
                            vm.fetchAllRecording()
                        
                    }
            }
        }
    }
}

#Preview {
    VoiceRecordView()
}


