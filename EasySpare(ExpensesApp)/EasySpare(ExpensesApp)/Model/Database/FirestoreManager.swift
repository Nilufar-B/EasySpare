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
    
    func saveTransaction(_ transaction: Transactions, userId: String) {
            db.collection("users").document(userId).collection("expenses").addDocument(data: [
                "title": transaction.title,
                "remarks": transaction.remarks,
                "amount": transaction.amount,
                "dateAdded": Timestamp(date: transaction.dateAdded),
                "category": transaction.category,
                "tintColor": transaction.tintColor
            ]) { error in
                if let error = error {
                    print("Error saving transaction: \(error.localizedDescription)")
                }
            }
        }
    
    func fetchTransactions(userId: String, completion: @escaping ([Transactions]) -> Void) {
            db.collection("users").document(userId).collection("expenses").getDocuments { (snapshot, error) in
                var transactions: [Transactions] = []
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let data = document.data()
                        if let title = data["title"] as? String,
                           let remarks = data["remarks"] as? String,
                           let amount = data["amount"] as? Double,
                           let dateAddedTimestamp = data["dateAdded"] as? Timestamp,
                           let categoryString = data["category"] as? String,
                           let tintColorString = data["tintColor"] as? String,
                           let category = Category(rawValue: categoryString),
                           let tintColor = tints.first(where: { $0.color == tintColorString }) {
                            let transaction = Transactions(
                                title: title,
                                remarks: remarks,
                                amount: amount,
                                dateAdded: dateAddedTimestamp.dateValue(),
                                category: category,
                                tintColor: tintColor
                            )
                            transactions.append(transaction)
                        }
                    }
                }
                completion(transactions)
            }
        }
    }
