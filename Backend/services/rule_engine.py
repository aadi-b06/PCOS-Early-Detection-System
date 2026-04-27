def doctor_rule_engine(data):
    score = 0
    reasons = []

    # -------------------------
    # 1. Cycle & Period
    # -------------------------
    if data.get("Cycle(R/I)") == 1:
        score += 2
        reasons.append("Irregular menstrual cycle")

    if data.get("Cycle length(days)") and data["Cycle length(days)"] > 35:
        score += 2
        reasons.append("Long menstrual cycle")

    # -------------------------
    # 2. BMI (Obesity factor)
    # -------------------------
    if data.get("BMI") and data["BMI"] > 25:
        score += 2
        reasons.append("High BMI")

    # -------------------------
    # 3. Symptoms
    # -------------------------
    if data.get("hair growth(Y/N)") == 1:
        score += 2
        reasons.append("Excess hair growth (hirsutism)")

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
        reasons.append("Skin darkening (insulin resistance sign)")

    # -------------------------
    # 4. Hormonal Indicators
    # -------------------------
    if data.get("FSH/LH") and data["FSH/LH"] > 2:
        score += 3
        reasons.append("High FSH/LH ratio")

    if data.get("TSH (mIU/L)") and data["TSH (mIU/L)"] > 4:
        score += 1
        reasons.append("Thyroid imbalance")

    # -------------------------
    # 5. Blood Sugar
    # -------------------------
    if data.get("RBS(mg/dl)") and data["RBS(mg/dl)"] > 140:
        score += 2
        reasons.append("High blood sugar level")

    # -------------------------
    # FINAL DECISION
    # -------------------------
    if score >= 8:
        risk = "High"
    elif score >= 4:
        risk = "Moderate"
    else:
        risk = "Low"

    return risk, score, reasons