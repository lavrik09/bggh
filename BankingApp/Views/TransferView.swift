import SwiftUI

struct TransferView: View {
    @EnvironmentObject private var service: BankingService
    @EnvironmentObject private var viewModel: TransferViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section("Счёт списания") {
                    Picker("Счёт", selection: $viewModel.selectedAccount) {
                        ForEach(service.accounts) { account in
                            Text("\(account.name) · \(account.balance.formatted(.currency(code: account.currency)))")
                                .tag(Optional(account))
                        }
                    }
                }

                Section("Получатель") {
                    Picker("Кому", selection: $viewModel.selectedBeneficiary) {
                        ForEach(service.beneficiaries) { beneficiary in
                            Text("\(beneficiary.name) · \(beneficiary.bankName)")
                                .tag(Optional(beneficiary))
                        }
                    }
                    Button("Новый получатель") {
                        // show add flow
                    }
                }

                Section("Сумма") {
                    TextField("0", value: $viewModel.amount, format: .number)
                        .keyboardType(.decimalPad)
                    Toggle("Регулярный перевод", isOn: $viewModel.isRecurring)
                    TextField("Комментарий", text: $viewModel.note)
                }

                Section {
                    Button {
                        viewModel.submitTransfer()
                    } label: {
                        Text("Отправить")
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle("Перевод")
            .alert("Перевод отправлен", isPresented: $viewModel.showConfirmation) {
                Button("Готово", role: .cancel) {}
            }
        }
    }
}

#Preview {
    TransferView()
        .environmentObject(BankingService())
        .environmentObject(TransferViewModel(service: BankingService()))
}
