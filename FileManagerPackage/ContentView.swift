//
//  ContentView.swift
//  FileManagerPackage
//
//  Created by FIX PRICE on 4/27/24.
//

import SwiftUI

final class ViewModel: ObservableObject {
    @Published private(set) var actionDescription: String = "No actions taken"
    @Published var text: String = ""
    
    func saveData() {
        text = ""
        actionDescription = "Saved"
    }
    
    func resaveData() {
        text = ""
        actionDescription = "Resaved"
    }
    
    func deleteData() {
        text = ""
        actionDescription = "Deleted"
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            
            Text(viewModel.actionDescription)
            
            TextField(text: $viewModel.text) {
                Text("Enter text to save")
            }
            .padding()
            .background(Color.green)
            .cornerRadius(10)
            .padding()
            
            Button {
                viewModel.saveData()
            } label: {
                Text("Save data")
                    .foregroundStyle(.background)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5)
            }
            
            Button {
                viewModel.resaveData()
            } label: {
                Text("Resave data")
                    .foregroundStyle(.background)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5)
            }
            
            Button {
                viewModel.deleteData()
            } label: {
                Text("Delete data")
                    .foregroundStyle(.background)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5)
            }
        }
    }
}

#Preview {
    ContentView()
}
