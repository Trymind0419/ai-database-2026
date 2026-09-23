# FastAPI 데이터 연동

## 개요

- FastAPI - Python 으로 API 서버를 만드는 웹 프레임워크
- API - Application Programing Interface
- 사용자(클라이언트)가 웹, 모바일, 앱에서 요청을 보내면 FastAPI 서버가 요청을 처리, 결과를 반환
- JSON 타입(파이썬 딕셔너리와 유사)으로 결과 리턴
- 예시

```plaintext
사용자(클라이언트)
-> GET /students 요청
-> FastAPI 서버에서 DB를 조회
-> 학생목록 결과 JSON 응답
```

###### 질문: 웹이 뭐예요??

- 답변: 요청에 대한 응답. 클라이언트(요청: Request) -> 서버(응답: Response)

### FastAPI 특징

- Python 문법으로 API 를 만들 수 있음.
- Code 가 간결하다.
- 실행 속도가 빠르다.
- 테스트를 위한 UI 를 자동으로 만들어 줌.
- Pydantic 을 사용, 요청과 응답 데이터를 검즐할 수 있다.
- PostgreSQL, MySQL, Oracle 등 DB와 연동이 쉽다.

### API 서버란

- 클라이언트 요청을 받아 필요한 작업을 수행, 그 결과를 클라이언트에게 돌려주는 프로그램

## 개발환경 설정

### FastAPI 패키지 설치

```BASH
# VS Code에서 터미널 열어서 적음
pip install fastapi uvicorn
```

- 현재 파이썬에 fastapi와 uvicorn 패키지를 설치
- fastapi 개발 가능

```bash
pip list
```

- 패키지 설치 확인

### 기초 FastAPI 서버

- [소스](./Day06/main.py) 작성
- VS Code 재시작

### 문제해결

- 설치한 uvicorn.exe 실행파일 위치가 Python 설치 위치와 상이
- C:\Users\User\AppData\Roaming\Python\Python314\Scripts 경로가 시스템 경로에 등록되어야 함
- window + R -> sysdm.cpl
- ![](assets/20260918_164500_image.png)
- ![](assets/20260918_164601_image.png)
- ![](assets/20260918_164805_image.png)
- 시스템 변수 내 Path 상세에서 파이썬 경로 추가
- 끝나고 확인 3번
- VS Code, 터미널 재시작

### FastAPI 서버 시작

```BASH
uvicorn main --reload --port 8000
```

- `-- reload` : 수정되면 곧바로 반영되어서 서버 재시작
- `-- port 8000` : 서버를 시작할 포트 지정
- http://127.0.0.1:8000 메시지 확인

  - 127.0.0.1 -> localhost
  - ![](assets/20260918_170916_image.png)

### FastAPI 기본 학슴

#### 웹 응답코드

- 200 : OK 웹페이지에 문제 없음.
- 404 : 페이지 Not Found. 클라이언트가 요청한 페이지나 데이터가 없음.
- 500 : Internal Server Error 내부 서버 오류.

#### Swagger UI 확인

- FastAPI 에서 자동으로 제공하는 API 테스트 페이지
- http(s)://address:port/docs
- ![](assets/20260921_101453_image.png)
- 클라이언트 웹페이지에서 데이터를 수정하거나 넣을 수 없으니 위 화면과 같은 Swagger 에서 해야함.
- api의 결과는 json 타입(문자열 일반적으로 "로 표현, 파이썬 딕셔너리 '로 표현하는 것과 차이점)

#### 경로

- URL 기본 `http(s)://address:port`
  - address - 127.0.0.1 또는 192.168.0.105 등 IP주소, www.naver.com, google.com 등의 도메인 주소
  - port - 0 ~ 65535 까지의 숫자
- `/` - root 기본되는 페이지
- ex) `/students` - 추가 URL, Restfull URL
- ex) `/students/1` - 추가 URL. 파라미터
- `/?key=value&key=value` - URL 경로 GET쿼리 파라미터 (옛날 방식)

#### HTTP(s) 메서드 ★★

FastAPI 는 주소와 HTTP 메서드도 파악 필요

- ![](assets/20260921_112303_image.png)
- GET 메서드 외에는 Swagger UI 에서 테스트 해야함. POST, PUT, PATCH, DELETE.
- GET 만 URL에서 처리 가능!
- ![](assets/20260921_112746_image.png)

#### 요청 본문

- POST 나 PATCH 요청시는 클라이언트가 JSON으로 데이터를 서버에 전달해야 함. 그래야 그 데이터를 등록 또는 수정.
- FastAPI에서는 Pydantic 패키지 모델을 사용
- JSON 데이터이므로 파이썬 None 대신 null 로 사용
- } 닫기 전 ','는 제거 (파이썬은 허용)

#### 메모리 기반 (DB 사용 X) 학생 API 예제

- day05/memorydb.py
- GET method 함수 내용 생략

##### POST 학생 정보 생성

- POST 메서드 작성
- Swagger에서 테스트

  - Try it out 클릭
  - Request body 클릭
  - ![](assets/20260921_135845_image.png)

##### HTTPException

- API 상에 오류가 발생하면 오류(예외) 처리를 진행
-


| 상태코드   | 의미                   |
| ---------- | ---------------------- |
| `200`, 201 | 요청 성공, 생성 성공   |
| 403,`404`  | 권한 없음, 데이터 없음 |
| `500`      | 서버 오류              |

## Day 6일차

### DB연동 FastAPI

- 실제 DB(PostgreSQL) 연동, 데이터를 가져와 사용하는 API 웹서버 구현
- 일반적인 API 서버 구조

```plaintext
fastapi_postgres(day06)/
│
├── main.py          # FastAPI 실행 및 API
├── database.py      # PostgreSQL 연결
├── models.py        # 데이터 모델
│
└── requirements.txt # 필요한 패키지
```

- 더 간단한 구조

```plaintext
fastapi_postgres(day06)/
│
├── main.py          # FastAPI 웹 서버
└── database.py      # PostgreSQL 연결
```

#### DB 연동 파이썬 패키지 설치

- psycopg 설치

```bash
pip install psycopg[binary]
```

- 내 개발환경(파이썬 패키지) 공유

설치 목록(타 개발자에게 보내주면 requirements 만 install 하면 내용물 다 받아짐.)

```bash
pip freeze > requirements.txt
```

- 개발환경 재설치

```bash
pip install -r requirements.txt
```

#### 기존 PostgreSQL students 테이블 사용

- 테이블 생성 내용 생략

##### database.py

##### main.py

- ![](assets/20260922_145631_image.png)

#### 디버깅

##### 기본 파이썬 디버깅
- Debug - 버그를 고치는 작업
- 소스코드 작성에 60%, 디버그 40% 시간 소요
- 디버그 단축키 리스트
  - F5 : 디버그로 실행
  - F9 : 브레이크포인트 토글 (토글: 한번은 활성화 한번은 비활성화)
  - F10 : 한 단계씩 실행(함수 패스)
  - F11 : 한 단계씩 실행(함수 내 진입)

  ##### Fast API 디버깅
  - 기본 FastAPI 코드 외 아래의 디버그 코드 추가

```python
import uvicorn

# 기존코드 생략

if __name__ == '__main__':
  uvicorn.run(
      'main:app',
      host='127.0.0.1',
      port=8000,
      reload=True,
      log_level='debug'
  )
```

- 디버깅 필요한 함수나 로직에 `F9`로 종단점(Break Point) 활성화
- `F5`(디버그 모드)로 실행
- 로직 실행하면 종단점에 일시 중단
- `F10`/`F11`로 한 줄씩 실행하면서 로직 처리 결과 모니터링, 조사식과 변수에서 데이터 확인
- 오류 로직을 찾아서 수정
- 다시 디버깅으로 정상동작 확인하고 완료


### FastAPI 추가학습 리스트

#### DB 연동
- `ORM`(Object-Relational Mapping) - SQL쿼리 없이 파이썬 코딩만으로 DB CRUD 가능한 기술
  - SQLAlchemy 패키지를 pip로 설치 후 사용
- `Docker` DB 컨테이너 연계


#### API 서버 활용
- 예외처리, 응답모델 구조 정리
- API 서버 프로젝트 구조화 - py 파일 분리, 환경 파일
- 인증(로그인, 권한), `JWT`(Json Web Token) 사용자 인증 - oauth2.0 구글로그인, 네이버로그인, 카카오로그인 연계
- Docker로 배포