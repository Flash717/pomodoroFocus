//
//  WorkTimerView.swift
//  PomodoroFocus
//
//  Created by Florian Knaus on 2/16/24.
//

import SwiftUI

struct WorkTimerView: View {
    @ObservedObject var viewModel = ViewModel()
    @State private var tapped = false
    @State private var dimmed = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Toggle(isOn: $dimmed) {
                    Text("Dimm")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                Spacer()
                
                Text(viewModel.secondsToMinutesAndSeconds(viewModel.workTimeRemaining))
                    .font(.system(size: 90))
                    .foregroundColor(dimmed ? .black : .white)
                
                Spacer()
                
                HStack(alignment: .center, spacing: 50) {
                    if viewModel.workTimerMode == .running || viewModel.workTimerMode == .paused {
                        Button(action: {
                            viewModel.resetTimers()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .bold()
                                .font(.system(size: 20))
                        }
                    }
                    
                    Button (action: {
                        if viewModel.workTimerMode == .running {
                            viewModel.pauseTimers()
                            tapped.toggle()
                        } else {
                            viewModel.startWorkTimer()
                            tapped.toggle()
                        }
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 70, height: 70)
                                .foregroundColor(Color("purpleTheme"))
                            Image(systemName: viewModel.workTimerMode == .running ? "pause.fill" : "play.fill")
                                .foregroundColor(.black)
                                .font(.system(size: 34))
                        }
                    }
                    
                    if viewModel.workTimerMode == .running || viewModel.workTimerMode == .paused {
                        Button(action: {
                            viewModel.advaceOneMinuteForward()
                        }) {
                            Image(systemName: "goforward")
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                                .rotationEffect(.degrees(60))
                                .font(.system(size: 20))
                        }
                    }
                }
            }
            .padding(.bottom, 50)
        }
    }
}

struct WorkTimerView_Previews: PreviewProvider {
    static var previews: some View {
        WorkTimerView()
    }
}
