import Foundation
import FileManagerSPM

final class ViewModel: ObservableObject {
    @Published private(set) var actionDescription: String = "No actions taken"
    @Published var text: String = ""
    @Published var fileNameWithoutExtension: String = ""
    
    private let fileManager = FileManagerSPM()
    
    func saveData() {
        let data = Data(text.utf8)
        do {
            try fileManager.saveInAppDirectory(
                data: data,
                with: fileNameWithoutExtension,
                with: ".txt"
            )
            actionDescription = "Saved"
        } catch {
            actionDescription = error.localizedDescription
        }
        
        text = ""
        fileNameWithoutExtension = ""
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
