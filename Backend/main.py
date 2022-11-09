import mysql.connector
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

mydb = mysql.connector.connect(
  host="bvyzl5ww60wo1qixlc1d-mysql.services.clever-cloud.com",
  user="upkeisefpfktydi2",
  password="sloo8ouS6cnBvcryb2A2",
  database="bvyzl5ww60wo1qixlc1d"
)

cursor = mydb.cursor()

class TokenProvided(BaseModel):
    token: str

@app.get("/test")
async def test():
    return {"message": "Test answer"}


@app.post("/getbalance")
async def get_balance(token_data: TokenProvided):
    token = token_data.token
    cursor.execute('SELECT * FROM user_tokens WHERE token = %s', (token,))
    row = cursor.fetchone()

    if row is None:
        return {"has_error": 1, "error_description": "Token is wrong"}

    user_id = row[1]

    cursor.execute('SELECT * FROM banking_accounts WHERE user_id = %s', (user_id,))
    row = cursor.fetchone()

    if row is None:
        return {"has_error": 2, "error_description": "User don't have bank account"}

    return {"balance": row[2]}
