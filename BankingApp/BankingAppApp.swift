import SwiftUI

@main
struct BankingAppApp: App {
    @StateObject private var service = BankingService()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(service)
        }
    }
}
