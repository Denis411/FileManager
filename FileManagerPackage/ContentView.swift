import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            
            Text(viewModel.actionDescription)
            
            TextField(.init("Enter text to save"), text: $viewModel.text)
                .padding()
                .background(Color.green)
                .cornerRadius(10)
                .padding()
            
            Button {
                viewModel.saveData()
            } label: {
                Text("Save data")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5)
            }
            
            Button {
                viewModel.resaveData()
            } label: {
                Text("Resave data")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5)
            }
            
            Button {
                viewModel.deleteData()
            } label: {
                Text("Delete data")
                    .foregroundColor(.white)
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
