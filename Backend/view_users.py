import sqlite3

conn = sqlite3.connect('users.db')
cursor = conn.cursor()

cursor.execute("SELECT * FROM users")
rows = cursor.fetchall()

print("Saved Users:\n")

for row in rows:
    print(f"ID: {row[0]} | Username: {row[1]} | Password: {row[2]}")

conn.close()