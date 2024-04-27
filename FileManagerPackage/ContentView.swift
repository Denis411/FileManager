import SwiftUI

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
