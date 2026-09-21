# 메모리기반 학생 관리 API
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

# 데이터 받을 형식
class StudentModel(BaseModel):
    name: str
    age: int
    major: str

# 가짜 데이터 만들기(가상의 DB)
students = [
    {'id' : 1, 'name' : '김철수', 'age' : 21, 'major' : '인공지능'},
    {'id' : 2, 'name' : '이영희', 'age' : 22, 'major' : '빅데이터'},
    {'id' : 3, 'name' : '성유고', 'age' : 25, 'major' : '컴퓨터공학'}
]

@app.get('/')
def read_root():
    return { 'message' : 'Hello FastAPI!'}

@app.get('/health')
def get_status():
    return{ 'message' : 'Server is OK'}






@app.get('/students')
def get_students():
    # select * from students; 와 동일
    return students # 위에 선언한 배열을 그대로 출력(돌려줌)

@app.get('/students/{id}')
def get_student(id: int):
    # select * from students where id = 1; 동일
    for student in students:
        if student['id'] == id:
            return student

    # 404 페이지 에러 처리(예외 처리)
    raise HTTPException(status_code=404, detail='Student not Found')

# 신규 데이터 추가
@app.post('/students')
def create_student(student: StudentModel):
    # insert into students (...) values (...); 동일
    # 현재 students 배열 최대값 +1 새 아이디
    new_id = max(item['id'] for item in students) + 1

    new_student = { # 파이썬 내 딕셔너리가 json으로 변경
        'id' : new_id,
        'name' : student.name,
        'age' : student.age,
        'major' : student.major
    }

    students.append(new_student) # id가 추가된 new_student
    return students # 배열 전체 리턴

# 기존 데이터 전체 수정
@app.put('/students/{id}')
def update_student(id: int, student: StudentModel):
    # update students set ... where id = 1; 동일
    for item in students:
        if item['id'] == id:
            item['name'] = student.name
            item['age'] = student.age
            item['major'] = student.major

            return item #수정완료한 한 건만 리턴

    # 예외처리
    raise HTTPException(status_code=404, detail='Student not found')


# 기존 데이터에서 일부만 수정 - 잘 사용안함. put으로 대체 가능
@app.patch('/student/{id}')
def patch_student(id: int, student: StudentModel):
    for item in students:
        if item['id'] == id:
            if student.name is not None: #student에 이름이 들어있으면 
                item['name'] = student.name

            if student.age is not None:
                item['age'] = student.age

            if student.major is not None:
                item['major'] = student.major

            return item

    raise HTTPException(status_code=404, detail='Student not Found')


# 삭제
@app.delete('/students/{id}')
def deleted_student(id: int):
    # delete from students where id = 1; 동일
    for index, student in enumerate(students):
        if student['id'] == id:
            #전체 학생배열에서 현재 index의 값만 뽑아냄(배열에서 사라짐)
            deleted_student = students.pop(index)

            return{
                'message': 'Student deleted',
                'student': deleted_student #deleted_student 변수는 def 함수가 return까지 다 표현하면 사라짐.
            } 
    raise HTTPException(status_code=404, detail='Student not Found')