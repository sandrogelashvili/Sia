//
//  FilterView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 11.07.24.
//

import SwiftUI

struct FilterView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 50)
            
            HStack {
                Spacer()
                Button(action: {
                    isPresented = false
                }) {
                    Text("Done")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            
            Form {
                // Add your filter options here
                Section(header: Text("Category")) {
                    Toggle("Option 1", isOn: .constant(false))
                    Toggle("Option 2", isOn: .constant(false))
                }
                
                Section(header: Text("Price Range")) {
                    Slider(value: .constant(50), in: 0...100)
                }
                
                // Add more filter sections as needed
            }
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}
