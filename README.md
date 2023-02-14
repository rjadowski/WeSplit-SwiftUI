# WeSplit App
WeSplit is a simple iOS app that allows you to split a bill and calculate the amount per person, including the tip.

# Requirements
Xcode 12.0 or later
iOS 14.0 or later
How to Use
Open the WeSplit app.
Enter the check amount in the "Amount" text field.
Select the number of people from the "Number of people" picker.
Select a tip percentage from the "Tip percentage" picker or tap the "Custom Tip" button to enter a custom tip percentage.
The "Amount per person" and "Total amount" sections will be updated with the calculated values.

# Architecture
The app is built using SwiftUI, a modern framework for building user interfaces. The main view of the app is defined in the ContentView struct, which contains a form with various input fields, and a navigation bar with the title "WeSplit".

The app uses state properties to keep track of the check amount, number of people, tip percentage, and whether the amount text field is focused or not. It also includes a computed property to calculate the tip percentage as a string, and two more computed properties to calculate the total amount per person and the grand total.

The "Tip percentage" section contains a segmented control with pre-defined tip percentages and a "Custom Tip" button that opens a TipPercentageView sheet. This sheet allows the user to select a custom tip percentage from a picker, and includes a "Save" button to save the selected value and dismiss the sheet.

The app also includes a toolbar with a "Done" button to dismiss the keyboard.

# Preview
The ContentView struct includes a ContentView_Previews struct that allows you to preview the app in Xcode. To use it, simply open the file in Xcode and click on the "Preview" button in the canvas.
