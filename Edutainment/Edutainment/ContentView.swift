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

public struct QuestionMultiplication {
    let questionNumber: Int
    let questionA: Int
    let questionB: Int
    
    func getQuestionText() -> String {
        return "What is \(questionA) X \(questionB)"
    }
    
    func getAnswer() -> Int {
        return questionA * questionB
    }
}

struct ContentView: View {
    @State private var currentState: StateGame = .setting
    @State private var questionAmount: Int = 2
    @State private var topBoundQuestion: Int = 3
    @State private var bottomBoundQuestion: Int = 2
    private var bottomBoundQuestionNumber: Int = 2
    private var topBoundQuestionNumber: Int = 10
    private var bottomBoundQuestionAmount: Int = 2
    private var topBoundQuestionAmount: Int = 10
    var body: some View {
        switch currentState {
        case .setting:
            ZStack {
                Color.mint
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    Text("Setting")
                        .foregroundStyle(.white)
                        .font(.title)
                        .bold()
                    Spacer()
                    VStack {
                        Stepper("Question Amount: \(questionAmount)", value: $questionAmount, in: bottomBoundQuestionAmount...topBoundQuestionAmount, step: 1)
                        .foregroundStyle(.white)
                        
                    }.padding()
                    VStack(spacing: 0) {
                        Text("Range of Multiplication Number")
                            .foregroundStyle(.white)
                            .font(.headline)
                        Stepper("Bottom Number: \(bottomBoundQuestion)", value: $bottomBoundQuestion, in: bottomBoundQuestionNumber...topBoundQuestionNumber, step: 1) { _ in
                            if bottomBoundQuestion >= topBoundQuestion {
                                bottomBoundQuestion = bottomBoundQuestion - 1
                            }
                        }
                        .foregroundStyle(.white)
                        Stepper("Top Number: \(topBoundQuestion)", value: $topBoundQuestion, in: bottomBoundQuestionNumber...topBoundQuestionNumber, step: 1){ _ in
                            if bottomBoundQuestion >= topBoundQuestion {
                                topBoundQuestion = topBoundQuestion + 1
                            }
                        }
                        .foregroundStyle(.white)
                        
                    }.padding()
                    Spacer()
                    VStack {
                        Button(action: {
                            currentState = .active
                        }, label: {
                            Text("Start")
                                .padding(.all, 12)
                                .foregroundColor(.white)
                                .background(Color.green)
                                .font(.title)
                        })
                        .clipShape(.capsule(style: .continuous))
                    }
                    Spacer()
                    
                }
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
