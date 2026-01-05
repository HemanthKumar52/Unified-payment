const admin = require('firebase-admin');
const path = require('path');
const fs = require('fs');

// IMPORTANT: The user must place their serviceAccountKey.json in backend/src/config/
// For now, we'll check if it exists, otherwise we'll mock it or initialize with default credentials (which works well in GCP/Firebase environments).

let serviceAccount;
const serviceAccountPath = path.join(__dirname, 'serviceAccountKey.json');

try {
  if (fs.existsSync(serviceAccountPath)) {
    serviceAccount = require(serviceAccountPath);
    admin.initializeApp({
        credential: admin.credential.cert(serviceAccount)
    });
    console.log("Firebase Admin initialized with serviceAccountKey.json");
  } else {
    // Fallback: This is useful if the user hasn't added the key yet or is using emulators/ADC
    console.log("No serviceAccountKey.json found. Attempting to initialize with application-default credentials...");
    admin.initializeApp(); 
  }
} catch (error) {
    console.error("Firebase Initialization Error (Expected if no keys):", error.message);
}

let db;
try {
    db = admin.firestore();
} catch (e) {
    console.log("Firestore not available. Using in-memory mock for demo.");
    // Simple mock for allowing the server to start without crashing
    db = {
        collection: () => ({
            doc: () => ({
                get: async () => ({ exists: false, data: () => ({}) }),
                set: async () => {},
                id: 'mock_id_' + Date.now()
            }),
            where: () => ({
                limit: () => ({
                    get: async () => ({ empty: true, docs: [] })
                })
            })
        })
    };
}

module.exports = { admin, db };

