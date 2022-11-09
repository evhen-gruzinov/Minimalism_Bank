from fastapi import FastAPI
import mysql.connector

app = FastAPI()  # notice that the app instance is called `app`, this is very important.

mydb = mysql.connector.connect(
  host="21h.h.filess.io",
  port=3305,
  user="SimpleBank_patternrod",
  password="fbfdb7d9325b77033dc4b9eadfd7405398efbb2d",
  database="SimpleBank_patternrod"
)

token = "PRv7xXESmpRdr8"
cursor = mydb.cursor()

is_limited = True



# row = cursor.fetchone()
# print(row)


# if row is None:
#     print( {"has_error": 1, "error_description": "Token is wrong"})
#
# user_id = row[1]
#
# query = "SELECT * FROM `transactions` WHERE `user_id` = %s"
# if is_limited:
#     query += " LIMIT 5"
#
# cursor.execute(query, (user_id,))
# transactions_rows = cursor.fetchall()
#
# transactions = []
#
# for row in transactions_rows:
#     transactions.append({
#         "id": row[0],
#         "user_id": row[1],
#         "account_id": row[2],
#         "type": row[3],
#         "amount": row[4],
#         "category": row[5],
#         "title": row[6],
#         "date": row[7].strftime("%Y-%m-%d"),
#         "state": row[8]
#     })
#
# print({"data": transactions})