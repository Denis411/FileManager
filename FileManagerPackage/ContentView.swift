import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 5){
            Text(viewModel.actionDescription)
            
            Group {
                TextField(.init("Enter text to save"), text: $viewModel.text)
                TextField(.init("File name without extension"), text: $viewModel.fileNameWithoutExtension)
            }
            .padding()
            .background(Color.green)
            .cornerRadius(10)
            .padding(.horizontal, 10)
            
            Group {
                Button {
                    viewModel.saveData()
                } label: {
                    Text("Save data")
                }
                
                Button {
                    viewModel.resaveData()
                } label: {
                    Text("Resave data")
                }
                
                Button {
                    viewModel.deleteData()
                } label: {
                    Text("Delete data")
                }
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(5)
        }
    }
}

#Preview {
    ContentView()
}
