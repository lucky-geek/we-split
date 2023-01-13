//
//  ContentView.swift
//  WeSplit
//
//  Created by Dennis Hazanovich on 2023-01-11.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocusted: Bool
    
    let currency = Locale.current.currency?.identifier ?? "USD"
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        return totalIncludingTip / Double(numberOfPeople)
    }
    
    var totalIncludingTip: Double {
        return billAmount + (billAmount / 100 * Double(tipPercentage))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Bill amount", value: $billAmount, format: .currency(code: currency))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocusted)
                } header: {
                    Text("Bill amount")
                }
                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100, id:\.self) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                } header: {
                    Text("Number of people")
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip Percentage")
                }
                Section {
                    Text(totalIncludingTip, format:  .currency(code: currency))
                } header: {
                    Text("Total with tip")
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: currency))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocusted = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
