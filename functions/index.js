// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access the Firebase Realtime Database.
const admin = require('firebase-admin');
admin.initializeApp();


exports.onAddExpenseIncrementTotalValue = functions.firestore
    .document('/userFinance/{userId}/expenses/{expenseId}')
    .onCreate((snapshot, context) => {
        let userId = context.params.userId;

        const db = admin.firestore();
        const userFinanceRef = db.collection('userFinance').doc(userId);

        return db.runTransaction(t => {
            return t.get(userFinanceRef)
            .then(userFinanceDoc => {
                t.update(userFinanceRef, {
                    totalSpent: (userFinanceDoc.data().totalSpent || 0) + snapshot.data().value
                });
            })
        }).then(result => {
            console.log("Increased aggregate expenses amount total value");
        }).catch(err => {
            console.log("Failed to increased aggregate expenses amount total value", err);
        });
    });
