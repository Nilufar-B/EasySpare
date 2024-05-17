//
//  FirestoreManager.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-14.
//

import Foundation
import FirebaseFirestore

class FirestoreManager {
    static let shared = FirestoreManager()
    private let db = Firestore.firestore()

    func saveTransaction(_ transaction: Transactions, userId: String, completion: @escaping () -> Void) {
        let transactionData: [String: Any] = [
            "title": transaction.title,
            "remarks": transaction.remarks,
            "amount": transaction.amount,
            "dateAdded": transaction.dateAdded,
            "category": transaction.category.rawValue,
            "tintColor": transaction.tintColor
        ]

        db.collection("users").document(userId).collection("transactions").addDocument(data: transactionData) { error in
            if let error = error {
                print("Error saving transaction: \(error.localizedDescription)")
            } else {
                completion()
            }
        }
    }

    func fetchTransactions(userId: String, completion: @escaping ([Transactions]) -> Void) {
        db.collection("users").document(userId).collection("transactions").getDocuments { (snapshot, error) in
            var transactions: [Transactions] = []
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let transaction = Transactions(
                        id: document.documentID, // Use documentID as the id
                        title: data["title"] as? String ?? "",
                        remarks: data["remarks"] as? String ?? "",
                        amount: data["amount"] as? Double ?? 0,
                        dateAdded: (data["dateAdded"] as? Timestamp)?.dateValue() ?? Date(),
                        category: Category(rawValue: data["category"] as? String ?? "") ?? .expense,
                        tintColor: data["tintColor"] as? String ?? ""
                    )
                    transactions.append(transaction)
                }
            }
            completion(transactions)
        }
    }

    func deleteTransaction(userId: String, transactionId: String, completion: @escaping (Error?) -> Void) {
        db.collection("users").document(userId).collection("transactions").document(transactionId).delete { error in
            completion(error)
        }
    }
}
