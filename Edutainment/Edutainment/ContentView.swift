//
//  ContentView.swift
//  Edutainment
//
//  Created by Galih Samudra on 22/05/24.
//

import SwiftUI

enum StateGame {
    case setting, active, finish
}

struct ContentView: View {
    @State private var currentState: StateGame = .setting
    var body: some View {
        switch currentState {
        case .setting:
            ZStack {
                Color.gray
                    .ignoresSafeArea()
                VStack {
                    Text("Setting Game")
                        .foregroundStyle(.white)
                        .font(.title)
                        .bold()
                    Button("Start") {
                        currentState = .active
                    }
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    .bold()
                    
                }
                .padding()
            }
        case .active:
            ZStack {
                Color.green
                    .ignoresSafeArea()
                VStack {
                    Text("Active Game")
                        .foregroundStyle(.white)
                        .font(.title)
                        .bold()
                    Button("Result") {
                        currentState = .finish
                    }
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    .bold()
                }
                .padding()
            }
        case .finish:
            ZStack {
                Color.brown
                    .ignoresSafeArea()
                VStack {
                    Text("Result Game")
                        .foregroundStyle(.white)
                        .font(.title)
                        .bold()
                    Button("Back to Setting") {
                        currentState = .setting
                    }
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    .bold()
                    
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
