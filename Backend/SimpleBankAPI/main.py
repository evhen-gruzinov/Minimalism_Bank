import mysql.connector
from fastapi import FastAPI
from pydantic import BaseModel
import dblogins

app = FastAPI()

mydb = mysql.connector.connect(
  host=dblogins.host,
  port=dblogins.port,
  user=dblogins.user,
  password=dblogins.password,
  database=dblogins.database
)

cursor = mydb.cursor(buffered=True)

class TokenOnly(BaseModel):
    token: str

class BalanceInfo(BaseModel):
    token: str
    need_balance: bool
    need_transactions: bool
    transactions_count: int

@app.get("/test")
async def test():
    return {"message": "Test answer"}


@app.post("/checkToken")
async def check_token(inputdata: TokenOnly):
    token = inputdata.token
    cursor.execute('SELECT * FROM user_tokens WHERE token = %s ', (token,))
    row = cursor.fetchone()

    if row is None:
        return {"has_error": 1, "error_description": "Token is wrong"}
    else:
        return {"user_id": row[1]}

@app.post("/getBalanceInfo")
async def get_balance_info(inputdata: BalanceInfo):
    token = inputdata.token
    need_balance = inputdata.need_balance
    need_transactions = inputdata.need_transactions
    transactions_count = inputdata.transactions_count

    return_data = {}

    cursor.execute('SELECT * FROM user_tokens WHERE token = %s ', (token,))
    row = cursor.fetchone()

    if row is None:
        return {"has_error": 1, "error_description": "Token is wrong"}
    user_id = row[1]
    return_data["user_id"] = user_id

    cursor.execute('SELECT * FROM banking_accounts WHERE user_id = %s', (user_id,))
    balance_row = cursor.fetchone()
    if balance_row is None:
        return {"has_error": 2, "error_description": "User don't have bank account"}


    if need_balance:
        return_data["balance"] = balance_row[2]

    if need_transactions:
        transactions = []

        query = "SELECT * FROM `transactions` WHERE `user_id` = %s ORDER BY `date` DESC"
        if transactions_count > 0:
            query += " LIMIT " + str(transactions_count)

        cursor.execute(query, (user_id,))
        transactions_rows = cursor.fetchall()

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

        return_data["transactions"] = transactions

    return return_data