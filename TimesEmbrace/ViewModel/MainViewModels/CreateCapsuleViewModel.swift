import SwiftUI

class CreateCapsuleViewModel: ObservableObject {
    @Published var selectedType: CapsuleType = .video  
    @Published var textContent: String = ""
    @Published var mediaURL: URL = (URL(string: "file:///var/mobile/Containers/Data/Application/1B48A20B-EDCC-4CCF-87DD-276E267FA461/Documents/9DE34E22-12CB-4AF4-AFDA-7CB38B80AF8B.m4a")!)
    
    private var context = PersistenceController.shared.container.viewContext
    
    func saveCapsule(title: String, text: String?, mediaURL: URL?, openingDate: Date, creationDate: Date, tag: String?) {
        let newCapsule = CapsuleEntity(context: context)
        newCapsule.id = UUID()
        newCapsule.title = title
        newCapsule.text = text
        newCapsule.mediaURL = mediaURL
        newCapsule.openingDate = openingDate
        newCapsule.creationDate = Date()
        
        context.perform {
            do {
                try self.context.save()
                print("Save data capsule")
            } catch {
                print("Failed to save data capsule: \(error)")
            }
        }
    }
}
