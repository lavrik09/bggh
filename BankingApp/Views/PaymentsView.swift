import SwiftUI

struct PaymentsView: View {
    @EnvironmentObject private var service: BankingService
    @EnvironmentObject private var viewModel: PaymentsViewModel

    @State private var newProvider = ""
    @State private var newAmount = ""
    @State private var newDate = Date()

    var body: some View {
        Form {
            Section("Предстоящие счета") {
                ForEach(service.bills) { bill in
                    Button {
                        viewModel.selectedBill = bill
                        viewModel.amount = bill.amount
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(bill.provider)
                                Text(bill.type.rawValue)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text(bill.amount.formatted(.currency(code: bill.currency)))
                                Text("До \(bill.dueDate, format: .dateTime.day().month())")
                                    .font(.caption)
                            }
                        }
                    }
                }
            }

            Section("Оплата") {
                Text(viewModel.selectedBill?.provider ?? "Выберите счет")
                TextField("Сумма", value: $viewModel.amount, format: .number)
                Toggle("Автоплатеж", isOn: $viewModel.autoPayEnabled)
                Button("Оплатить") {
                    viewModel.paySelectedBill()
                }
            }

            Section("Новый счет") {
                TextField("Поставщик", text: $newProvider)
                TextField("Сумма", text: $newAmount)
                    .keyboardType(.decimalPad)
                DatePicker("Дата", selection: $newDate, displayedComponents: .date)
                Button("Сохранить") {
                    guard let amount = Double(newAmount) else { return }
                    viewModel.scheduleNew(provider: newProvider, amount: amount, date: newDate)
                    newProvider.removeAll()
                    newAmount.removeAll()
                }
            }
        }
        .navigationTitle("Платежи")
        .alert("Платёж выполнен", isPresented: $viewModel.paymentScheduled) {
            Button("OK", role: .cancel) {}
        }
    }
}

#Preview {
    NavigationStack {
        PaymentsView()
            .environmentObject(BankingService())
            .environmentObject(PaymentsViewModel(service: BankingService()))
    }
}
