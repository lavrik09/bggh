import Foundation
import Combine

final class BankingService: ObservableObject {
    @Published private(set) var accounts: [Account]
    @Published private(set) var cards: [Card]
    @Published private(set) var transactions: [Transaction]
    @Published private(set) var bills: [Bill]
    @Published private(set) var beneficiaries: [Beneficiary]

    @Published var selectedAccount: Account?
    @Published var notificationsEnabled = true
    @Published var faceIDEnabled = true
    @Published var pushCategories: Set<String> = ["Переводы", "Платежи", "Кэшбэк"]

    init(
        accounts: [Account] = [.sample,
                               Account(
                                   id: UUID(),
                                   name: "Накопительный 7%",
                                   type: .savings,
                                   currency: "RUB",
                                   balance: 1_050_000,
                                   accountNumber: "4230 78•• ••00 1801",
                                   interestRate: 0.07,
                                   goalProgress: 0.82
                               ),
                               Account(
                                   id: UUID(),
                                   name: "Инвестиции",
                                   type: .investment,
                                   currency: "USD",
                                   balance: 11_300,
                                   accountNumber: "4080 50•• ••50 4400",
                                   interestRate: nil,
                                   goalProgress: 0.45
                               )],
        cards: [Card] = Card.sampleCards(),
        transactions: [Transaction] = Transaction.sampleData(),
        bills: [Bill] = Bill.sampleBills(),
        beneficiaries: [Beneficiary] = Beneficiary.sampleBeneficiaries()
    ) {
        self.accounts = accounts
        self.cards = cards
        self.transactions = transactions
        self.bills = bills
        self.beneficiaries = beneficiaries
        self.selectedAccount = accounts.first
    }

    func totalBalance(in currency: String = "RUB") -> Double {
        let localized = accounts.filter { $0.currency == currency }.reduce(0) { $0 + $1.balance }
        return localized
    }

    func makeTransfer(from account: Account, to beneficiary: Beneficiary, amount: Double) {
        guard amount > 0 else { return }
        updateAccount(account) { acc in
            acc.balance -= amount
        }
        let transaction = Transaction(
            id: UUID(),
            title: "Перевод: \(beneficiary.name)",
            subtitle: beneficiary.bankName,
            amount: amount,
            currency: account.currency,
            date: Date(),
            category: .transfers,
            isDebit: true
        )
        transactions.insert(transaction, at: 0)
    }

    func payBill(_ bill: Bill) {
        guard let account = selectedAccount else { return }
        updateAccount(account) { acc in
            acc.balance -= bill.amount
        }
        transactions.insert(
            Transaction(
                id: UUID(),
                title: bill.provider,
                subtitle: bill.type.rawValue,
                amount: bill.amount,
                currency: bill.currency,
                date: Date(),
                category: .utilities,
                isDebit: true
            ),
            at: 0
        )
    }

    func toggleCardLock(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards[index].isLocked.toggle()
        }
    }

    func scheduleBill(_ provider: String, amount: Double, dueDate: Date) {
        let bill = Bill(
            id: UUID(),
            provider: provider,
            type: .utilities,
            amount: amount,
            currency: "RUB",
            dueDate: dueDate,
            isAutoPayEnabled: false
        )
        bills.append(bill)
    }

    func addBeneficiary(name: String, bank: String, accountNumber: String) {
        let beneficiary = Beneficiary(
            id: UUID(),
            name: name,
            type: .personal,
            bankName: bank,
            accountNumber: accountNumber,
            recentAmount: nil,
            currency: "RUB"
        )
        beneficiaries.append(beneficiary)
    }

    private func updateAccount(_ account: Account, update: (inout Account) -> Void) {
        guard let index = accounts.firstIndex(where: { $0.id == account.id }) else { return }
        var updated = accounts[index]
        update(&updated)
        accounts[index] = updated
        if selectedAccount?.id == updated.id {
            selectedAccount = updated
        }
    }
}
