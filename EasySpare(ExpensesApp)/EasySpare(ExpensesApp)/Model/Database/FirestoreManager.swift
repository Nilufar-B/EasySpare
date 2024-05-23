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
       
        // Create a dictionary of transaction data to save

        let transactionData: [String: Any] = [
            "title": transaction.title,
            "remarks": transaction.remarks,
            "amount": transaction.amount,
            "dateAdded": transaction.dateAdded,
            "category": transaction.category.rawValue,
            "tintColor": transaction.tintColor
        ]
        // Add a new document to the user's transactions collection
        db.collection("users").document(userId).collection("transactions").addDocument(data: transactionData) { error in
            if let error = error {
                print("Error saving transaction: \(error.localizedDescription)")
            } else {
                completion() // Call the completion handler if the transaction is successfully saved
            }
        }
    }

    func fetchTransactions(userId: String, completion: @escaping ([Transactions]) -> Void) {
        // Get all documents from the user's transactions collection
        db.collection("users").document(userId).collection("transactions").getDocuments { (snapshot, error) in
            var transactions: [Transactions] = []
            if let snapshot = snapshot {
                for document in snapshot.documents {  // Loop through each document in the snapshot
                    let data = document.data()
                    let transaction = Transactions(  // Create a Transactions object from the document data
                        id: document.documentID, // Use documentID as the id
                        title: data["title"] as? String ?? "",
                        remarks: data["remarks"] as? String ?? "",
                        amount: data["amount"] as? Double ?? 0,
                        dateAdded: (data["dateAdded"] as? Timestamp)?.dateValue() ?? Date(),
                        category: Category(rawValue: data["category"] as? String ?? "") ?? .expense,
                        tintColor: data["tintColor"] as? String ?? ""
                    )
                    transactions.append(transaction)  // Append the transaction to the transactions array
                }
            }
            completion(transactions)
        }
    }
    func updateTransaction(transaction: Transactions, userId: String, completion: @escaping () -> Void) {
        // Reference to the specific document to update
        let docRef = db.collection("users").document(userId).collection("transactions").document(transaction.id)
        // Set new data for the document
        docRef.setData([
                "title": transaction.title,
                "remarks": transaction.remarks,
                "amount": transaction.amount,
                "dateAdded": transaction.dateAdded,
                "category": transaction.category.rawValue,
                "tintColor": transaction.tintColor
            ]) { error in
                if let error = error {
                    print("Error updating transaction: \(error.localizedDescription)")
                } else {
                    print("Transaction successfully updated!")
                    completion()
                }
            }
        }

    func deleteTransaction(userId: String, transactionId: String, completion: @escaping (Error?) -> Void) {
        db.collection("users").document(userId).collection("transactions").document(transactionId).delete { error in
            completion(error)
        }
    }
}
