# FastAPI 다시
from fastapi import FastAPI
from pydantic import BaseModel


app = FastAPI()  # API 서버 시작

# 클래스 : 함수의 변형. 현재는 데이터 구조만
# () 내 부모 파라미터
class StudentModel(BaseModel):
     name: str # 이름 문자열로 받음
     email: str # 이메일 문자열로 받음
     age: int # 나이 정수로 받음
     major: str | None = None # 전공 문자열로 받음

@app.get('/root') # '/' 경로 뒤에 hi 붙였으니 마지막에 /hi 적어야 열림.
def read_root():
    return {'message' : 'Hello FastAPI!'}

# --reload: 변경사항이 있으면 변경사항을 적용하여 서버를 돌려라

@app.get('/') # 데코레이션
def get_students():
    return [
        {'id' : 1,'name' : '김철수','major' : '인공지능'},
        {'id' : 2,'name' : '이영희','major' : '데이터분석'},
        {'id' : 3,'name' : '성유고','major' : '컴퓨터공학'}
    ]


@app.get('/students/{id}')
def get_students(id: int):
    return {'students_id' : id}

@app.get('/search')
def search_student(major: str | None = None):
    return {'major' : major}

@app.post('/students')
def create_students(student: StudentModel):
        return { 'message' : '학생등록',
                 'data' : student
                }

@app.patch('/students/{id}')
def update_student(id: int):
     return { 'message' : f'{id}번 학생 수정'}

@app.put('/students/{id}')
def put_student(id: int):
     return { 'message' : f'{id}번 학생 수정'}

@app.delete('/students/{id}')
def delete_student(id: int):
     return { 'message': f'{id}번 학생 삭제'}