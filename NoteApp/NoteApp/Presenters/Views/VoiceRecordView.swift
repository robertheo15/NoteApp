//
//  VoiceRecordView.swift
//  Endxiety
//
//  Created by Ali Haidar on 11/07/24.
//

import SwiftUI

struct VoiceRecordView: View {
    enum SiriState {
        case none
        case thinking
    }
    @State var state: SiriState = .none
    
    // Ripple animation vars
    @State var counter: Int = 0
    @State var origin: CGPoint = .init(x: 0.5, y: 0.5)
    
    // Gradient and masking vars
    @State var gradientSpeed: Float = 0.03
    @State var timer: Timer?
    @State private var maskTimer: Float = 0.0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Colorful animated gradient
                MeshGradientView(maskTimer: $maskTimer, gradientSpeed: $gradientSpeed)
                    .scaleEffect(1.3) // avoids clipping
                    .opacity(containerOpacity)
                
                // Brightness rim on edges
                if state == .thinking {
                    RoundedRectangle(cornerRadius: 52, style: .continuous)
                        .stroke(Color.white, style: .init(lineWidth: 4))
                        .blur(radius: 4)
                }
                
                // Phone background mock, includes button
                SiriBackground(state: $state, origin: $origin, counter: $counter)
                    .mask {
                        AnimatedRectangle(size: geometry.size, cornerRadius: 48, t: CGFloat(maskTimer))
                            .scaleEffect(computedScale)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .blur(radius: animatedMaskBlur)
                    }
            }
        }
        .ignoresSafeArea()
//        .modifier(RippleEffect(at: origin, trigger: counter))
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                DispatchQueue.main.async {
                    maskTimer += rectangleSpeed
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
        .toolbar {
            NavigationLink{
                EmotionRateView()
            }label: {
                Image(systemName: "checkmark")
            }
        }
    }
    
    private var computedScale: CGFloat {
        switch state {
        case .none: return 1.2
        case .thinking: return 1
        }
    }
    
    private var rectangleSpeed: Float {
        switch state {
        case .none: return 0
        case .thinking: return 0.03
        }
    }
    
    private var animatedMaskBlur: CGFloat {
        switch state {
        case .none: return 8
        case .thinking: return 28
        }
    }
    
    private var containerOpacity: CGFloat {
        switch state {
        case .none: return 0
        case .thinking: return 1.0
        }
    }
}

#Preview {
    VoiceRecordView()
}

struct SiriBackground: View {
    @Binding var state: VoiceRecordView.SiriState
    @Binding var origin: CGPoint
    @Binding var counter: Int
    
    private var scrimOpacity: Double {
        switch state {
        case .none:
            0
        case .thinking:
            0.8
        }
    }
    
    private var iconName: String {
        switch state {
        case .none:
            "mic"
        case .thinking:
            "stop.fill"
        }
    }

    var body: some View {
        ZStack {
//            Image("Background", bundle: .main)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .scaleEffect(1.2) // avoids clipping
//                .ignoresSafeArea()
            
            Rectangle()
                .fill(Color.black)
                .opacity(scrimOpacity)
                .scaleEffect(1.2) // avoids clipping
            
            VStack {
                welcomeText
                
                siriButtonView
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .onPressingChanged { point in
                if let point {
                    origin = point
                    counter += 1
                }
            }
            .padding(.bottom, 64)
        }
    }
    
    @ViewBuilder
    private var welcomeText: some View {
        if state == .thinking {
            ListeningSiriAnimation()
                .foregroundStyle(Color.white)
                .frame(maxWidth: 240, maxHeight: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.bold)
                .animation(.easeInOut(duration: 0.2), value: state)
                .contentTransition(.opacity)
            
            
        }
    }
    
    private var siriButtonView: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.9)) {
                switch state {
                case .none:
                    state = .thinking
                case .thinking:
                    state = .none
                }
            }
        } label: {
            Image(systemName: iconName)
                .contentTransition(.symbolEffect(.replace))
                .frame(width: 96, height: 96)
                .foregroundStyle(Color.white)
                .font(.system(size: 32, weight: .bold, design: .monospaced))
                .background(
                    Circle()
                        .fill(Color.red)
                )
        }
    }
}
