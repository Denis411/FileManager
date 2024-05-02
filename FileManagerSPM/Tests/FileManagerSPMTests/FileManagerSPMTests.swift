import XCTest
@testable import FileManagerSPM

final class FileManagerSPMTests: XCTestCase {
    private let data = "This is data for testing, it should be deleted".data(using: .utf8)!
    private let fileName = "TestFile"
    private let fileExtension = "json"
    
    private let package = FileManagerSPM()
    
    override func setUpWithError() throws {
        do {
            try self.removeFile(with: fileName, with: fileExtension)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func testSavingWithValidData() async {
        // give
        let shouldOverwriteFile = false
        // when
        do {
            try await package.saveInAppDirectory(
                data: data,
                fileName: fileName,
                fileExtension: fileExtension,
                shouldOverwriteFile: shouldOverwriteFile
            )
        } catch {
            // then 1
            print(error.localizedDescription)
            XCTFail()
        }
        
        do {
            let hasFileBeenSaved = try doesFileExist(with: fileName, with: fileExtension)
            if !hasFileBeenSaved {
                // then 2
                print(#line.description, "file has not beed persisted")
                XCTFail()
            }
        } catch {
            // then 3
            print(error.localizedDescription)
            XCTFail()
        }
    }
    
    func testSavingWithInvalidExtension() async {
        // give
        let shouldOverwriteFile = false
        let invalidFileExtension = ".json"
        // when
        do {
            try await package.saveInAppDirectory(
                data: data,
                fileName: fileName,
                fileExtension: invalidFileExtension,
                shouldOverwriteFile: shouldOverwriteFile
            )
        } catch {
            // then
            guard error as? FileManagerErrors == FileManagerErrors.fileExtensionFirstCharacterIsDot else {
                XCTFail()
                return
            }
        }
    }
    
    func testSavingWithoutName() async {
        // give
        let shouldOverwriteFile = false
        let emptyFileName = ""
        let invalidFileExtension = "json"
        // when
        do {
            try await package.saveInAppDirectory(
                data: data,
                fileName: emptyFileName,
                fileExtension: invalidFileExtension,
                shouldOverwriteFile: shouldOverwriteFile
            )
        } catch {
            // then
            guard error as? FileManagerErrors == FileManagerErrors.fileWithoutName else {
                XCTFail()
                return
            }
        }
    }
    
    func testDoubleSavingToTheSameDirectory() async {
        // give
        let invalidFileExtension = "json"
        let shouldOverwriteFile = false
        // when
        do {
            try await package.saveInAppDirectory(
                data: data,
                fileName: fileName,
                fileExtension: invalidFileExtension,
                shouldOverwriteFile: shouldOverwriteFile
            )
            
            try await package.saveInAppDirectory(
                data: data,
                fileName: fileName,
                fileExtension: invalidFileExtension,
                shouldOverwriteFile: shouldOverwriteFile
            )
        } catch {
            // then
            guard error as? FileManagerErrors == FileManagerErrors.fileAlreadyExists else {
                XCTFail()
                return
            }
        }
    }

}

extension FileManagerSPMTests {
    private func getAppDirectory() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
    }
    
    private func doesFileExist(with fileName: String, with fileExtension: String) throws -> Bool {
        let appDirectory = try getAppDirectory()
        
        let fileURL = appDirectory
            .appendingPathComponent(fileName)
            .appendingPathExtension(fileExtension)
        
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    private func removeFile(with fileName: String, with fileExtension: String) throws {
        let appDirectory = try getAppDirectory()
        
        let fileURL = appDirectory
            .appendingPathComponent(fileName)
            .appendingPathExtension(fileExtension)
        
        try FileManager.default.removeItem(at: fileURL)
    }
}
