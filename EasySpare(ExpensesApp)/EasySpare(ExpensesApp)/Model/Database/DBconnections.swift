//
//  DBconnections.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-14.
//

import Foundation
import FirebaseFirestore

class DBConnections {
    
    static let shared = DBConnections()
    private init() {} // Private initializer for singleton
    
    private let db = Firestore.firestore()


    // Saving a user profile
    func saveUserProfile(userProfile: UserProfile) {
        db.collection("users").document(userProfile.userName).setData([
            "plannedExpenses": userProfile.plannedExpenses
        ]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }

    
    func fetchUserProfile(userName: String, completion: @escaping (UserProfile?) -> Void) {
        db.collection("users").document(userName).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let plannedExpenses = data?["plannedExpenses"] as? Double ?? 0
                completion(UserProfile(userName: userName, plannedExpenses: plannedExpenses))
            } else {
                print("Document does not exist")
                completion(nil)
            }
        }
    }
    
    // Create a collection of user expenses
    func createUserExpensesCollection(userId: String) {
        let expensesCollection = db.collection("users").document(userId).collection("expenses")
        
        // Adding an example entry to initialize a collection
        expensesCollection.addDocument(data: [
            "title": "Initial Expense",
            "remarks": "Example",
            "amount": 0.0,
            "dateAdded": Timestamp(date: Date()),
            "category": "expense",
            "tintColor": "Gray"
        ]) { error in
            if let error = error {
                print("Error creating initial expenses collection: \(error.localizedDescription)")
            } else {
                print("Initial expenses collection created successfully!")
            }
        }
    }
}
