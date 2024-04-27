import Foundation
import FileManagerSPM

final class ViewModel: ObservableObject {
    @Published private(set) var actionDescription: String = "No actions taken"
    @Published var text: String = ""
    @Published var fileNameWithoutExtension: String = ""
    
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
