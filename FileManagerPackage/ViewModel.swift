import Foundation
import FileManagerSPM

@MainActor
final class ViewModel: ObservableObject {
    @Published private(set) var actionDescription: String = "No actions taken"
    @Published var text: String = ""
    @Published var fileNameWithoutExtension: String = ""
    @Published var shouldOverwriteExistingFile: Bool = false
    
    private let fileManager: FileManagerSPMProtocol = FileManagerAssembly().create()
    
    func saveData() {
        Task {
            let data = Data(text.utf8)
            do {
                try await fileManager.saveInAppDirectory(
                    data: data,
                    fileName: fileNameWithoutExtension,
                    fileExtension: "txt",
                    shouldOverwriteFile: shouldOverwriteExistingFile
                )
                actionDescription = "Saved"
            } catch {
                actionDescription = error.localizedDescription
            }
            
            text = ""
            fileNameWithoutExtension = ""
        }
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
