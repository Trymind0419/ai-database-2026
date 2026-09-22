# day05 main.py, memorydb.py와 동일 + DB처리 추가
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
# 우리가 만든 database.py
from database import get_connection
from psycopg.rows import dict_row # [추가] dict_row 임포트
import uvicorn # 디버깅시 추가할 것.



app = FastAPI(title='FastAPI DB 연동')

# 학생 모델
class StudentModel(BaseModel):
    name : str
    email : str | None = None # DB에 null 가능
    age : int | None = None # DB에 null 가능
    major : str


# 전체학생 조회
@app.get('/students')
def get_students():
    conn = get_connection() #실제 DB연결 / connection = conn / F12  누르면 함수가 잘 연결됐는지 확인가능
    # Ctrl + / 는 해당 줄 주석처리
    cursor = conn.cursor(row_factory=dict_row) # 마우스커서처럼 테이블 한행을 가리키는 값
    try: # 실제 사용할 구문
        # 실제 쿼리는 DBeaver 등에서 작성 확인하고 복사해 옴
        cursor.execute(""" 
            select id, name, email, age, major, created_at
              from students
            order by id   
        """) #세미 콜론 안씀. select * from students 안함.
        # 위 쿼리를 실행해서 모든 데이터를 다 가져와 students에 할당
        students = cursor.fetchall()
        if students is None:
            raise HTTPException(status_code=404, detail='Student not Found')
        return students
        
    # except Exception : #예외

    finally: # 예외 여부 관계없이 항상 실행
        cursor.close() #커서도 닫아줌 #close 작업 반드시 필요. 계속 데이터가 차니까
        conn.close()  #예외가 발생하든 안하든 무조건 DB 연결 닫아야함.

# 한명 조회
@app.get('/students/{id}')
def get_student(id: int):
    conn = get_connection()
    cursor = conn.cursor(row_factory=dict_row) # 연결 후에 커서 만듦

    try:
        # 쿼리 실행, 외부에서 받는 값은 %s로 변경, 값은 (id, ) 형식 작성
        cursor.execute("""
            select id, name, email, age, major, created_at
                from students
            where id = %s
        """, (id, ))
        student = cursor.fetchone()

        if student is None:
            raise HTTPException(status_code=404, detail='Student not Found')
        return student
    finally:
        cursor.close() # 접속 종료 전에 커서를 닫기
        conn.close()

# 학생 등록
@app.post('/students')
def create_student(student: StudentModel):
    conn = get_connection()
    cursor = conn.cursor(row_factory=dict_row)

    try: # %d는 사용불가
        cursor.execute("""
            insert into students (name, email, age, major)
            values (%s, %s, %s, %s)
        """, (student.name, student.email, student.age, student.major))

       # new_student = cursor.fetchone() # 새로 DB에 등록된 학생정보

        conn.commit() #!!! 데이터가 제대로 들어갔으면 commit

        return {'message' : 'Student registration done'}
    except:
        conn.rollback() # 롤백
        raise
    finally:
        cursor.close()
        conn.close()

# 수정. Patch 일부 수정은 거의 사용 안함
@app.put('/students/{id}')
def update_student(id: int, student: StudentModel):
    conn = get_connection()
    cursor = conn.cursor(row_factory=dict_row)

    try:
        cursor.execute("""
            update students set
                name = %s,
                age = %s,
                email = %s,
                major = %s
            where id = %s
            returning id, name, email, age, major, created_at
        """, (student.name, student.age, student.email, student.major, id))
        #변수
        updated_student = cursor.fetchone()

        if updated_student is None:
            conn.rollback()
            raise HTTPException(status_code=404, detail='Student not Found')
        conn.commit() # 빼면 안됨. 넣어야 무조건 DB가 바뀜!!!
        return updated_student
    except:
        conn.rollback()
        raise
    finally:
        cursor.close()
        conn.close()


# 삭제
@app.delete('/students/{id}')
def delete_student(id: int):
    conn = get_connection()
    cursor = conn.cursor(row_factory=dict_row)

    try:
        cursor.execute("""
                delete from students
                  where id = %s
            returning id, name
        """, (id, ))

        deleted_student = cursor.fetchone()

        if deleted_student is None:
            conn.rollback()
            raise HTTPException(status_code=404, detail='Student not Found')

        conn.commit()
        return{
            'message' : 'Student deleted',
            'student' : deleted_student
        }
    except:
        conn.rollback()
        raise

    finally:
        cursor.close()
        conn.close()


# 디버깅시 추가할 것
if __name__ == '__main__':
    uvicorn.run(
        'main_debug:app', # 파이썬 파일명이 main_debug
        host='127.0.0.1',
        port=8001,
        reload=True,
        log_level='debug'
    )