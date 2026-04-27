# 🩺 PCOS Early Detection System

An AI-powered mobile application designed for the early screening and management of Polycystic Ovary Syndrome (PCOS). This project combines a **Flutter** mobile interface with a **Flask (Python)** backend utilizing machine learning models and a custom rule engine for high-accuracy detection.

## 🚀 Features

* **Symptom Tracking:** Log and monitor menstrual cycles, physical symptoms, and lifestyle habits.
* **AI-Powered Screening:** Utilizes a Machine Learning model (`pcos_model.pkl`) to predict the likelihood of PCOS based on clinical parameters.
* **Rule-Based Analysis:** A secondary `rule_engine.py` to provide logic-based insights alongside AI predictions.
* **User Management:** Secure Login and Registration system with a local SQLite database (`users.db`).
* **Health Dashboard:** Visual representation of user health data and risk factors.
* **Lifestyle Recommendations:** Curated content on exercise, diet (healthy vs. junk food), and sleep.

---

## 🏗️ Project Structure

```text
├── Backend/                 # Python Flask API
│   ├── app.py               # Main API Gateway
│   ├── train_model.py       # ML Training script
│   ├── pcos_model.pkl       # Saved Random Forest/XGBoost Model
│   ├── scaler.pkl           # Data normalization constants
│   ├── users.db             # SQLite Database
│   └── services/            # Logic & Rule Engine
├── lib/                     # Flutter Frontend
│   ├── screens/             # UI Pages (Login, Tracker, Dashboard)
│   └── services/            # API Service to connect to Backend
├── dataset/                 # Raw & Cleaned CSV data for training
└── assets/                  # Images and icons used in the app
```

---

## 🛠️ Installation & Setup

### 1. Backend (Flask)
1. Navigate to the backend folder:
   ```bash
   cd Backend
   ```
2. Install dependencies:
   ```bash
   pip install flask flask_sqlalchemy pandas scikit-learn
   ```
3. Run the server:
   ```bash
   python app.py
   ```

### 2. Frontend (Flutter)
1. Ensure you have Flutter installed.
2. Get packages:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

---

## 📊 Data & Model
The system uses the **PCOS_data_cleaned.csv** dataset. 
* **Features:** Cycle length, weight gain, hair growth, skin darkening, and more.
* **Preprocessing:** Data is normalized using `scaler.pkl` and missing values are handled via `medians.pkl`.

---

## ⚖️ Disclaimer
*This application is for educational and early-screening purposes only. It is not a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of a qualified health provider with any questions regarding a medical condition.*
