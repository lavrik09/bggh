import Foundation

final class TransferViewModel: ObservableObject {
    @Published var selectedBeneficiary: Beneficiary?
    @Published var selectedAccount: Account?
    @Published var amount: Double = 0
    @Published var note: String = ""
    @Published var isRecurring = false
    @Published var showConfirmation = false

    private let service: BankingService

    init(service: BankingService) {
        self.service = service
        self.selectedAccount = service.selectedAccount
        self.selectedBeneficiary = service.beneficiaries.first
    }

    func submitTransfer() {
        guard let account = selectedAccount, let beneficiary = selectedBeneficiary else { return }
        service.makeTransfer(from: account, to: beneficiary, amount: amount)
        amount = 0
        note.removeAll()
        showConfirmation = true
    }
}
