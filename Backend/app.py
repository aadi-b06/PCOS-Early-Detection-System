from flask import Flask, request, jsonify
import pickle
import numpy as np
import sqlite3

app = Flask(__name__)

# =====================================================
# DATABASE INIT (ADD HERE)
# =====================================================

def init_db():
    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            password TEXT
        )
    ''')

    conn.commit()
    conn.close()

init_db()

# =====================================================
# LOAD SAVED OBJECTS
# =====================================================

model = pickle.load(open("pcos_model.pkl", "rb"))
scaler = pickle.load(open("scaler.pkl", "rb"))
medians = pickle.load(open("medians.pkl", "rb"))
feature_order = pickle.load(open("feature_order.pkl", "rb"))

# =====================================================
# DOCTOR RULE ENGINE
# =====================================================

def doctor_rule_engine(data):
    score = 0
    reasons = []

    if data.get("Cycle(R/I)") == 1:
        score += 2
        reasons.append("Irregular cycle")

    if data.get("Cycle length(days)") and float(data["Cycle length(days)"]) > 35:
        score += 2
        reasons.append("Long cycle length")

    if data.get("BMI") and float(data["BMI"]) > 25:
        score += 2
        reasons.append("High BMI")

    if data.get("hair growth(Y/N)") == 1:
        score += 2
        reasons.append("Excess hair growth")

    if data.get("Pimples(Y/N)") == 1:
        score += 1
        reasons.append("Acne")

    if data.get("Weight gain(Y/N)") == 1:
        score += 1
        reasons.append("Weight gain")

    if data.get("Hair loss(Y/N)") == 1:
        score += 1
        reasons.append("Hair loss")

    if data.get("Skin darkening (Y/N)") == 1:
        score += 2
        reasons.append("Skin darkening")

    if data.get("FSH/LH") and float(data["FSH/LH"]) > 2:
        score += 3
        reasons.append("High FSH/LH ratio")

    if data.get("TSH (mIU/L)") and float(data["TSH (mIU/L)"]) > 4:
        score += 1
        reasons.append("Thyroid imbalance")

    if data.get("RBS(mg/dl)") and float(data["RBS(mg/dl)"]) > 140:
        score += 2
        reasons.append("High blood sugar")

    if score >= 8:
        return "High", score, reasons
    elif score >= 4:
        return "Moderate", score, reasons
    else:
        return "Low", score, reasons


# =====================================================
# HOME ROUTE
# =====================================================

@app.route('/')
def home():
    return "Server running successfully"

# =====================================================
# REGISTER ROUTE
# =====================================================

@app.route('/register', methods=['POST'])
def register():
    data = request.json

    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()

    cursor.execute(
        "INSERT INTO users (username, password) VALUES (?, ?)",
        (data['username'], data['password'])
    )

    conn.commit()
    conn.close()

    return jsonify({"message": "User registered"})


# =====================================================
# LOGIN ROUTE
# =====================================================

@app.route('/login', methods=['POST'])
def login():
    data = request.json

    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()

    cursor.execute(
        "SELECT * FROM users WHERE username=? AND password=?",
        (data['username'], data['password'])
    )

    user = cursor.fetchone()
    conn.close()

    if user:
        return jsonify({"message": "Login successful"})
    else:
        return jsonify({"message": "Invalid credentials"}), 401

# =====================================================
# PREDICTION ROUTE
# =====================================================

@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.json

        features = []

        # Maintain correct feature order
        for feature in feature_order:
            value = data.get(feature)

            if value is None or value == "":
                value = medians[feature]

            features.append(float(value))

        features = np.array(features).reshape(1, -1)

        # Scale
        features_scaled = scaler.transform(features)

        # ML prediction
        probability = model.predict_proba(features_scaled)[0][1]

        # Rule engine
        rule_risk, score, reasons = doctor_rule_engine(data)

        # Final decision
        if probability > 0.7 or rule_risk == "High":
            final_risk = "High"
            recommendation = "Consult a gynecologist immediately."

        elif probability > 0.4 or rule_risk == "Moderate":
            final_risk = "Moderate"
            recommendation = "Monitor symptoms and consider doctor consultation."

        else:
            final_risk = "Low"
            recommendation = "Maintain healthy lifestyle."

        return jsonify({
            "risk_probability": round(float(probability), 3),
            "ml_risk": (
                "High" if probability > 0.7 else
                "Moderate" if probability > 0.4 else
                "Low"
            ),
            "rule_risk": rule_risk,
            "rule_score": score,
            "final_risk": final_risk,
            "reasons": reasons,
            "recommendation": recommendation
        })

    except Exception as e:
        return jsonify({"error": str(e)}), 500


# =====================================================
# RUN SERVER
# =====================================================

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)