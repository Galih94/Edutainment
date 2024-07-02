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
    @State private var questionAmount: Int = 10
    @State private var topBoundQuestion: Int = 3
    @State private var bottomBoundQuestion: Int = 2
    @State private var questions: [QuestionMultiplication] = []
    @State private var currentNumber: Int = 1
    @State private var currentScore: Int = 0
    @State private var currentAnswer: String = ""
    private let questionAmounts: [Int] = [5, 10, 20]
    private var bottomBoundQuestionNumber: Int = 2
    private var topBoundQuestionNumber: Int = 12
    private var bottomBoundQuestionAmount: Int = 2
    private var topBoundQuestionAmount: Int = 10
    
    private var isLastQuestion: Bool {
        return currentNumber == questionAmount
    }
    
    private func generateQuestion() {
        for i in 1...questionAmount {
            let questionA = Int.random(in: bottomBoundQuestion...topBoundQuestion)
            let questionB = Int.random(in: bottomBoundQuestion...topBoundQuestion)
            questions.append(QuestionMultiplication(questionNumber: i,
                                                    questionA: questionA,
                                                    questionB: questionB
                                                   ))
        }
    }
    
    private func gradeAnswer(index: Int) {
        if "\(questions[index].getAnswer())" == currentAnswer {
            currentScore += 1
        }
    }
    
    private func resetScore() {
        currentNumber = 1
        questions = []
        currentState = .setting
        currentScore = 0
    }
    
    private func processAnswer(index: Int) {
        gradeAnswer(index: index)
        if currentNumber == questionAmount  {
            currentState = .finish
        } else {
            currentNumber += 1
        }
        currentAnswer = ""
    }
    
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
                        Text("Question Amount: \(questionAmount)")
                            .foregroundStyle(.white)
                            .font(.headline)
                        Picker("", selection: $questionAmount, content: {
                            ForEach(questionAmounts, id: \.self) {
                                Text("\($0)")
                            }
                        })
                        .pickerStyle(.segmented)
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
                            generateQuestion()
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
                    Text("\(questions[currentNumber - 1].getQuestionText())")
                        .foregroundStyle(.white)
                        .font(.title)
                        .bold()
                    TextField("Enter your answer", text: $currentAnswer)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.numberPad)
                    Button(isLastQuestion ? "Result" : "Next Question") {
                        processAnswer(index: currentNumber - 1)
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
                    Text("Result Game: \(currentScore) / \(questionAmount)")
                        .foregroundStyle(.white)
                        .font(.title)
                        .bold()
                    Button("Back to Setting") {
                        resetScore()
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
