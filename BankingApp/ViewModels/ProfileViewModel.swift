import Foundation

final class ProfileViewModel: ObservableObject {
    @Published var notificationToggles: [String: Bool]
    @Published var faceIDEnabled: Bool
    @Published var theme: Theme = .system

    enum Theme: String, CaseIterable, Identifiable {
        case light = "Светлая"
        case dark = "Тёмная"
        case system = "Системная"

        var id: String { rawValue }
    }

    private let service: BankingService

    init(service: BankingService) {
        self.service = service
        self.notificationToggles = Dictionary(uniqueKeysWithValues: service.pushCategories.map { ($0, true) })
        self.faceIDEnabled = service.faceIDEnabled
    }

    func updateNotification(for key: String, enabled: Bool) {
        notificationToggles[key] = enabled
    }

    func sync() {
        service.faceIDEnabled = faceIDEnabled
        service.pushCategories = Set(notificationToggles.filter { $0.value }.map { $0.key })
    }
}
