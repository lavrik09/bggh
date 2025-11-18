import Foundation

struct Beneficiary: Identifiable, Hashable {
    enum BeneficiaryType: String {
        case personal = "Физлицо"
        case business = "Компания"
    }

    let id: UUID
    var name: String
    var type: BeneficiaryType
    var bankName: String
    var accountNumber: String
    var recentAmount: Double?
    var currency: String

    static func sampleBeneficiaries() -> [Beneficiary] {
        [
            Beneficiary(
                id: UUID(),
                name: "Анна Кузнецова",
                type: .personal,
                bankName: "Сбербанк",
                accountNumber: "4081 38•• ••77 1000",
                recentAmount: 15_000,
                currency: "RUB"
            ),
            Beneficiary(
                id: UUID(),
                name: "ООО ""Городской сервис""",
                type: .business,
                bankName: "Альфа Банк",
                accountNumber: "4070 28•• ••00 1100",
                recentAmount: 48_200,
                currency: "RUB"
            )
        ]
    }
}
