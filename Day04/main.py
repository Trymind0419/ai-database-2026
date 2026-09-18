# 파이썬에서 다른 패키지를 사용하려면
# from * import **
# import * 
# -> 다른 패키지를 불러와서 사용하는 것
from fastapi import FastAPI

app = FastAPI()

@app.get('/')
def read_root():
    return { 'message' : 'Hello FastAPI' }