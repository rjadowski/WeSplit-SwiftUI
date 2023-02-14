//
//  ContentView.swift
//  WeSplit
//
//  Created by Robbie Jadowski on 13/02/2023.
//

import SwiftUI

// The `ContentView` struct defines the main view of the app.
struct ContentView: View {
    // State properties for the amount of the check, the number of people, and the tip percentage.
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    // An array of possible tip percentages.
    let tipPercentages = [0, 10, 15, 20, 25]
    
    // A computed property that returns the tip percentage as a string.
    var tipPercentageString: String {
        return "\(tipPercentage)%"
    }
    
    // State property to track whether the amount text field is focused.
    @FocusState private var amountIsFocused: Bool
    
    // State property to track whether the tip percentage sheet is showing.
    @State private var showingTipPercentage = false
    
    // Computed property that calculates the total amount per person.
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    // Computed property that calculates the grand total.
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    // The body of the `ContentView` view, which contains the form and navigation.
    var body: some View {
        NavigationView {
            Form {
                // First section of the form that contains the amount text field and the number of people picker.
                Section {
                    // Amount text field that displays the check amount in currency format.
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    // Number of people picker that allows the user to select the number of people.
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                // Second section of the form that contains the tip percentage picker and the custom tip button.
                Section {
                    // Stack that contains the tip percentage picker and the custom tip button.
                    VStack{
                        // Tip percentage picker that allows the user to select a pre-defined tip percentage.
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }.pickerStyle(.segmented)
                        
                        // Custom tip button that opens the `TipPercentageView` sheet.
                        Button("Custom Tip (\(tipPercentageString))") {
                                self.showingTipPercentage = true
                            }
                            .buttonStyle(.borderedProminent)
                        }.sheet(isPresented: $showingTipPercentage) {
                            TipPercentageView(tipPercentage: $tipPercentage)
                    }
                }
                // Display amount per person
                Section(header: Text("Amount per person")) {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                // Display the grand total
                Section(header: Text("Total amount")) {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            // Adding a done button to keyboard toolbar
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
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

// TipPercentageView allows the user to select a custom tip percentage
struct TipPercentageView: View {
    @Binding var tipPercentage: Int
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            // Picker displays a picker with a label "Tip Percentage" and allows the user to select a tip percentage value.
            Picker("Tip Percentage", selection: $tipPercentage) {
                
                // ForEach loop creates a row for each value in the range 0 to 100, with the text displayed as the percentage value.
                ForEach(0 ..< 101) {
                    Text("\($0)%")
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 300, height: 200)
            
            // The Button displays a button with the text "Save". When the button is tapped, it updates the tipPercentage with its current value, and dismisses the view using the presentationMode.wrappedValue.dismiss() method.
            Button("Save") {
                self.tipPercentage = self.tipPercentage
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

