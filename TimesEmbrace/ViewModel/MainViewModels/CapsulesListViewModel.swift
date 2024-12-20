import SwiftUI

class CapsulesListViewModel: ObservableObject {
    private var context = PersistenceController.shared.container.viewContext
    
    @Published var selectedCapsule: CapsuleEntity?
    @Published var showDetailView = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func handleCapsuleTap(_ capsule: CapsuleEntity) {
        guard let openingDate = capsule.openingDate else { return }
        let currentDate = Date()

        if currentDate < openingDate {
            // Если капсула ещё закрыта
            alertMessage = "Капсулу можно открыть \(formattedDate(openingDate))."
            showAlert = true
        } else {
            // Если капсула открыта
            selectedCapsule = capsule
            showDetailView = true
        }
    }
    
    func deleteCapsule(_ capsule: CapsuleEntity) {
        context.delete(capsule)
        
        context.perform {
            do {
                try self.context.save()
                print("Delete data capsule")
            } catch {
                print("Failed to save data after delete capsule: \(error)")
            }
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
