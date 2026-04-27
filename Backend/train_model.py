import pandas as pd
import pickle
import numpy as np

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix, roc_auc_score
from imblearn.over_sampling import SMOTE


# =====================================================
# 1️⃣ LOAD DATASET
# =====================================================

df = pd.read_csv("dataset/PCOS_data_cleaned.csv")
print("Original Shape:", df.shape)


# =====================================================
# 2️⃣ CLEAN DATA
# =====================================================

# Remove unwanted Unnamed columns
df = df.loc[:, ~df.columns.str.contains("Unnamed")]

# Convert Cycle(R/I): 2 → 1 (Irregular)
df["Cycle(R/I)"] = df["Cycle(R/I)"].replace({2: 1})

# Fill missing numeric values with median
df = df.fillna(df.median(numeric_only=True))

print("After Cleaning Shape:", df.shape)
print("\nMissing Values:\n", df.isnull().sum())

print("\nClass Distribution:")
print(df["PCOS (Y/N)"].value_counts())


# =====================================================
# 3️⃣ SPLIT FEATURES AND TARGET
# =====================================================

X = df.drop("PCOS (Y/N)", axis=1)
y = df["PCOS (Y/N)"]

# Save feature order (VERY IMPORTANT for API)
feature_order = list(X.columns)
pickle.dump(feature_order, open("feature_order.pkl", "wb"))

# Save medians for optional fields
medians = df[feature_order].median()
pickle.dump(medians, open("medians.pkl", "wb"))


# =====================================================
# 4️⃣ TRAIN / TEST SPLIT
# =====================================================

X_train, X_test, y_train, y_test = train_test_split(
    X,
    y,
    test_size=0.2,
    random_state=42,
    stratify=y
)

print("\nTrain Size:", X_train.shape)
print("Test Size:", X_test.shape)


# =====================================================
# 5️⃣ HANDLE CLASS IMBALANCE USING SMOTE
# =====================================================

sm = SMOTE(random_state=42)
X_train, y_train = sm.fit_resample(X_train, y_train)

print("\nAfter SMOTE Class Distribution:")
print(pd.Series(y_train).value_counts())


# =====================================================
# 6️⃣ SCALE FEATURES
# =====================================================

scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)


# =====================================================
# 7️⃣ TRAIN RANDOM FOREST MODEL
# =====================================================

model = RandomForestClassifier(
    n_estimators=1000,
    max_depth=None,
    min_samples_split=2,
    min_samples_leaf=1,
    class_weight="balanced_subsample",
    random_state=42
)

model.fit(X_train, y_train)


# =====================================================
# 8️⃣ EVALUATE MODEL WITH CUSTOM THRESHOLD
# =====================================================

probs = model.predict_proba(X_test)[:, 1]

# Lower threshold for better recall (screening tool)
threshold = 0.35
y_pred = (probs >= threshold).astype(int)

print("\nAccuracy:", accuracy_score(y_test, y_pred))
print("\nClassification Report:\n", classification_report(y_test, y_pred))
print("\nConfusion Matrix:\n", confusion_matrix(y_test, y_pred))
print("\nROC AUC:", roc_auc_score(y_test, probs))


# =====================================================
# 9️⃣ SAVE MODEL AND SCALER
# =====================================================

pickle.dump(model, open("pcos_model.pkl", "wb"))
pickle.dump(scaler, open("scaler.pkl", "wb"))

print("\nModel, scaler, medians, and feature order saved successfully.")