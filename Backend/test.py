from fastapi import FastAPI
import mysql.connector

app = FastAPI()  # notice that the app instance is called `app`, this is very important.

mydb = mysql.connector.connect(
  host="bvyzl5ww60wo1qixlc1d-mysql.services.clever-cloud.com",
  user="upkeisefpfktydi2",
  password="sloo8ouS6cnBvcryb2A2",
  database="bvyzl5ww60wo1qixlc1d"
)

token = "PRv7xXESmpRdr8"

cursor = mydb.cursor()

cursor.execute('SELECT * FROM user_tokens WHERE token = %s', (token,))
row = cursor.fetchone()

if row is None:
    print( {"has_error": 1, "error_description": "Token is wrong"})

user_id = row[1]

cursor.execute('SELECT * FROM banking_accounts WHERE user_id = %s', (user_id,))
row = cursor.fetchone()

print( {"balance": row[2]} )