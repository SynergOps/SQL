import os
import psycopg2
from dotenv import load_dotenv

# Load variables from .env file
load_dotenv()

# Connect using environment variables
conn = psycopg2.connect(
    database=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT")
)

cur = conn.cursor()

cur.execute("DROP TABLE IF EXISTS ui_user;")

cur.execute("""
CREATE TABLE IF NOT EXISTS "ui_user" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    age INT,
    gender CHAR
);
""")

cur.execute("""
INSERT INTO ui_user (name, email, age, gender) VALUES
('Salih', '[EMAIL_ADDRESS]', 24, 'M'),
('Mina', '[EMAIL_ADDRESS]', 24, 'F'),
('Mike', '[EMAIL_ADDRESS]', 35, 'M'),
('Jordan', '[EMAIL_ADDRESS]', 40, 'F'),
('Mark', '[EMAIL_ADDRESS]', 45, 'M');
""")

#cur.execute("SELECT * FROM ui_user;")  # Fetch all rows
#print(cur.fetchone())  # print one row - call it again to print the next row

cur.execute("""
SELECT * FROM ui_user WHERE age > 30;
""")
for row in cur.fetchall():  # print all remaining rows after fetchone() or just use fetchall() to print all rows
    print(row)

conn.commit()

cur.close()
conn.close()