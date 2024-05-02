import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ScrollView {
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
                
                Toggle(isOn: $viewModel.shouldOverwriteExistingFile) {
                    Text("Should overwrite existing file")
                        .font(.system(size: 10))
                }
                .toggleStyle(.switch)
                .padding(.horizontal)
                .padding(.vertical, 5)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                .padding(.horizontal, 10)
                
                Button {
                    viewModel.saveData()
                } label: {
                    Text("Save data")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(5)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
