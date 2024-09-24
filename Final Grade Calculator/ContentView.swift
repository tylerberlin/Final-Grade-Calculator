//
//  ContentView.swift
//  Final Grade Calculator
//
//  Created by Tyler Berlin on 9/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentGradeTextField = ""
    @State private var finalWeightTextField = ""
    @State private var desiredGrade = 0.0
    @State private var requiredGrade = 0.0
    var body: some View {
        VStack {
            VStack{
                CustomText(text: "Final Grade Calculator")
                CustomTextField(placeholder: "Current Semester Grade", varriable: $currentGradeTextField)
                CustomTextField(placeholder: "Final Weight (%)", varriable: $finalWeightTextField)
                Picker("Desired Semester Grad", selection: $desiredGrade){
                    Text("A").tag(90.0)
                    Text("B").tag(80.0)
                    Text("C").tag(70.0)
                    Text("D").tag(60.0)
                }
                .pickerStyle(.segmented)
                .padding()
                Text("Required Grade on the Final")
                CustomText(text: String(format: "%.2f", requiredGrade))
                
                    .onChange(of: desiredGrade) { oldValue, newValue in
                        calculateGrade()
                    }
                Spacer()
            }
            .background(requiredGrade > 100 ?  Color.red : Color.green.opacity(requiredGrade > 0 ? 1.0 : 0.0))
            .padding()
        }
    }
    func calculateGrade(){
        if let currentGrade = Double(currentGradeTextField){
            if let finalWeight = Double(finalWeightTextField){
                if finalWeight < 100 && finalWeight > 0{
                    let finalPercentage = finalWeight / 100.0
                    requiredGrade = max(0.0,(desiredGrade - (currentGrade * (1.0 - finalPercentage))) / finalPercentage)
                }
            }
                else{
                    requiredGrade = 0.0
                }
            }
            else{
                requiredGrade = 0.0
        }
    }
}

#Preview {
    ContentView()
}

struct CustomTextField: View {
    let placeholder: String
    let varriable: Binding<String>
    var body: some View{
        TextField(placeholder, text: varriable)
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.center)
            .frame(width: 200, height: 30)
            .font(.body)
            .padding()
    }
}

struct CustomText: View {
    let text: String
    var body: some View{
        Text(text)
            .font(.title)
            .fontWeight(.bold)
    }
}
