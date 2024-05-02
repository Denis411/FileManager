import Foundation

public struct FileManagerAssembly {
    public init() { }
    public func create() -> FileManagerSPMProtocol {
        FileManagerSPM()
    }
}
