import Foundation

final class PaymentsViewModel: ObservableObject {
    @Published var selectedBill: Bill?
    @Published var amount: Double = 0
    @Published var autoPayEnabled = false
    @Published var paymentScheduled = false

    private let service: BankingService

    init(service: BankingService) {
        self.service = service
        self.selectedBill = service.bills.first
        self.amount = service.bills.first?.amount ?? 0
    }

    func paySelectedBill() {
        guard let bill = selectedBill else { return }
        service.payBill(bill)
        paymentScheduled = true
    }

    func scheduleNew(provider: String, amount: Double, date: Date) {
        service.scheduleBill(provider, amount: amount, dueDate: date)
    }
}
