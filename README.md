# 🏡 Villa Property App

## 📌 Overview
The Villa Property App is a mobile-based real estate application that simplifies buying and selling properties. It allows sellers to list their properties and buyers to explore, favorite, and schedule meetings with property owners or dealers — all from one platform.

The app focuses on a clean UI, smooth user experience, and real-time data handling using Firebase.

---

## 🚀 Features

### 👤 Buyer Features
- Browse properties by category (Villa, Apartment, Plot, Commercial, etc.)
- View detailed property information
- Add properties to favorites
- Schedule meetings with sellers
- Track scheduled meetings with status:
    - Pending
    - Approved
    - Rejected

### 🏠 Seller Features
- Add and manage own property listings
- View meeting requests from buyers
- Accept or reject meeting requests
- Track all incoming meeting requests

### 🔔 General Features
- Firebase Authentication
- Real-time data updates using Firestore
- Modern and minimal UI design
- Clean navigation and structured modules

---

## 🗂️ Meeting Management
- All meeting schedules are stored in a single common Firestore collection
- Each meeting contains:
    - Buyer ID
    - Seller ID
    - Property ID
    - Scheduled date & time
    - Status (Pending / Approved / Rejected)
- This structure avoids data duplication and ensures efficient updates.

---

## 🛠️ Tech Stack
- Frontend: Flutter (Dart)
- Backend: Firebase Firestore
- Authentication: Firebase Authentication
- UI Design: Custom modern UI with a soft color palette

---

## 🎨 UI Highlights
- Clean and modern design
- Card-based layouts for properties and meetings
- Separate views for:
    - Meetings scheduled by the user
    - Meetings requested by other buyers
- User-friendly empty-state messages with animations

---

## 📈 Future Enhancements
- Advanced search and filter options
- Chat between buyer and seller
- Map-based property viewing
- Admin panel for moderation

---

## 👨‍💻 Developer
Rutvik Kumbhar
Final Year Diploma in Computer Engineering  
Application Developer
