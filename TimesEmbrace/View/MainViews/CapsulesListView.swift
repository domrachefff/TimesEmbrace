import SwiftUI
import CoreData

struct CapsulesListView: View {
    @StateObject private var viewModel = CapsulesListViewModel()
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CapsuleEntity.openingDate, ascending: true)],
        animation: .default)
    private var capsules: FetchedResults<CapsuleEntity>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(capsules) { capsule in
                    Button {
                        viewModel.handleCapsuleTap(capsule)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(capsule.title ?? "Без названия")
                                .font(.headline)
                            if let openingDate = capsule.openingDate {
                                Text("Открывается: \(viewModel.formattedDate(openingDate))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.deleteCapsule(capsule)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .sheet(isPresented: $viewModel.showDetailView) {
                            CapsuleDetailView(capsule: capsule)
                    }
                }
                .navigationTitle("Time's Embrace")

                .alert("Внимание", isPresented: $viewModel.showAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(viewModel.alertMessage)
                }
            }
        }
    }
}

#Preview {
    CapsulesListView()
}
