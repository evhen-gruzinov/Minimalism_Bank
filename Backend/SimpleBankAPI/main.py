import mysql.connector
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

mydb = mysql.connector.connect(
  host="21h.h.filess.io",
  port=3305,
  user="SimpleBank_patternrod",
  password="fbfdb7d9325b77033dc4b9eadfd7405398efbb2d",
  database="SimpleBank_patternrod"
)

cursor = mydb.cursor(buffered=True)

class TokenProvided(BaseModel):
    token: str

class ForTransactions(BaseModel):
    token: str
    is_limited: bool


@app.get("/test")
async def test():
    # cursor.close()
    # mydb.close()
    return {"message": "Test answer"}


@app.post("/getbalance")
async def get_balance(inputdata: TokenProvided):
    token = inputdata.token

    cursor.execute('SELECT * FROM user_tokens WHERE token = %s', (token,))
    row = cursor.fetchone()

    if row is None:
        return {"has_error": 1, "error_description": "Token is wrong"}
    user_id = row[1]

    cursor.execute('SELECT * FROM banking_accounts WHERE user_id = %s', (user_id,))
    row = cursor.fetchone()
    if row is None:
        return {"has_error": 2, "error_description": "User don't have bank account"}

    # cursor.close()
    # mydb.close()

    return {"balance": row[2]}

@app.post("/gettransactions")
async def get_transactions(inputdata: ForTransactions):
    token = inputdata.token
    is_limited = inputdata.is_limited

    cursor.execute('SELECT * FROM user_tokens WHERE token = %s', (token,))
    row = cursor.fetchone()
    if row is None:
        return {"has_error": 1, "error_description": "Token is wrong"}
    user_id = row[1]

    query = "SELECT * FROM `transactions` WHERE `user_id` = %s"
    if is_limited:
        query += " LIMIT 5"

    cursor.execute(query, (user_id,))
    transactions_rows = cursor.fetchall()

    transactions = []

    for row in transactions_rows:
        transactions.append({
            "id": row[0],
            "user_id": row[1],
            "account_id": row[2],
            "type": row[3],
            "amount": row[4],
            "category": row[5],
            "title": row[6],
            "date": row[7].strftime("%Y-%m-%d"),
            "state": row[8]
        })

    # cursor.close()
    # mydb.close()

    return transactions