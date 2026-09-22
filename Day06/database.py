## PostgreSQL 데이터베이스 연동 파이썬

import psycopg # PostgreSQL 연결해주는 중간 역할, 
from psycopg.rows import dict_row #psycopg.rows에서 여러가지가 있는데 거기서 dict_row만 쓰겠다

# import만 쓸 시 전부 다 쓰겠다.
# from ~ import - : ~ 에서 = 만 쓰겠다.

# 우리가 만드는 함수 정의, get_connection을 통해 psycopg 내 connect 함수 이용
def get_connection():
    return psycopg.connect(
        host='localhost', # 127.0.0.1 동일
        port = 5432,
        dbname = 'ai_db', # 테이블 명 적는 것이 아님.
        user = 'postgres',
        password='123456'
    )