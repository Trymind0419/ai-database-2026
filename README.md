# ai-database-2026

AI 에이전트 개발자 데이터베이스 리포지토리

`: 소스 코드나 단어를 표시, **: 글자 bold

## 1일차

```
https://github.com/hugoMGSung/ai-database-2026
```

### PostgreSQL 개요

데이터베이스. 데이터를 한 군데에서 관리하는 목적의 시스템

줄여서 Postgre, Postgres 라고 통칭. **관계형** 데이터베이스.

`SQL`을 통해서 데이터를 **저장, 수정, 삭제, 조회**할 수 있는 시스템

- 기타 관계형 데이터베이스
  - Oracle
  - MySQL / MariaDB
  - SQL Server(from. Microsoft)

위 대부분 상용 소프트웨어, Postgre는 **오픈소스 시스템** 라이선스 비용 X

### DB의 특징

- 데이터 무결성: 데이터가 한 번 들어오면 변동이 없어야 함.
- 데이터 안정성: 한 번 들어온 데이터는 영구적으로 보관됨.
- 데이터 동시성: 한꺼번에 여러 사람이 동시에 쓸 수 있음.
- 표준 SQL 지원
- 확장성
- 대소문자 구분 안함.

### PostgreSQL 설치

#### 기본 설치

- 자신의 OS에 직접 설치하는 방법
- postgresql-18.6-3-windows-x64.exe
- superuser 아이디 - postgres 패스워드 지정
- **port 5432** 기억하기

### DBeaver 설치

- GUI DB관리 실행 툴
- 설치 생략

### DB 접속

1. DBeaver 실행

   ![](assets/20260915_121521_image.png)
2. 새 DB 연결
3. 데이터 베이스 설정![](assets/20260915_121759_image.png)
4. test connection 클릭 후 다운 받기
5.
6. 확인 후 완료
7.

### Docker 개요

가상 컨테이너 시스템(도커 내에서 모든 걸 설치할 수 있음. 예로 다른 운영체제에서 ~ 때문에 설치 못함. 해결)

윈도우에서 xCode는 힘들 수 있다고 말씀하심. ios 앱 개발자는 다 맥 보유.

- 환경 의존성 문제를 해결한 컨테이너 기술 솔루션
- **가상환경** 상 여러가지 프로그램 실행하게 만들어줌.
- 컨테이너 - OS, 라이브러리, 설정 등 하나의 패키지로 만들어진 이미지
- 기본 Docker 실행파일 -> Docker Desktop 윈도우에서 Docker를 편하게 사용하도록

### DBeaver Community

백엔드 서버는 보이지 않기 때문에 보면서 작업할 수 있게 해줌.

### Docker Desktop 설치

- https://docs.docker.com/desktop/setup/install/windows-install/
- 윈도우 버전으로 다운로드 후 설치
- Close and Restart 이후
- WSL(Windows Subsystem for Linux) 추가 설치(파워쉘 관리자 권한 열기 -> wsl --install)

### PostgreSQL 이미지 다운로드

- 이미지: Docker repository 에 미리 만들어놓은 시스템 패키지 (1. 먼저)
- 컨테이너: 나의 Docker 에서 미리 다운 받은 이미지를 동작시킨 시스템 (2. 다음)

#### Docker 기본 명령어

```bash
docker --version
```

- 설치된 도커 확인

#### Docker 에서 PostgreSQL 이미지 다운로드

```bash
docker pull postgres, or docker pull postgres:latest
```

- Docker Desktop 전체 검색에서 pull(다운로드)

### 컨테이너 실행

#### 도커 명령어로 실행

- 여러 옵션으로 실행을 해야하므로 거의 대부분 명령어로 실행

```bash
docker run --name my-postgres -e POSTGRES_PASSWORD=123456 -p 25432:5432 -d postgres:latest
```

- -p는 포트를 의미하는데 ' : ' 앞부분은 윈도우 포트(도커에서 호출할 때 쓰는 포트), 뒷부분은 도커 내부에서 돌아가는 포트다. 앞부분 포트는 내가 이미 윈도우에서 쓰고있는 것을 쓰면 안됨.

  ![](assets/20260915_165357_image.png)
- 체크한 것이 할당된 컨테이너의 아이디

#### DBeaver에서 접속

### DB 기본 사용법

#### PostgreSQL 기본 구조

![](assets/20260915_142904_image.png)

- ai_db - 데이터베이스(프로젝트 전체 공간)
- Schemas - 프로젝트 폴더
- Tables - 실제 데이터를 담는 표

#### DB 생성

![](assets/20260915_141221_image.png)

- SQL 편집기 클릭
- 새 이름으로 저장, 특정 이름명.sql로 저장
- ai_db 명칭의 새 데이터베이스 생성

```sql
create database ai_db;
```

- Ctrl + Enter 로 쿼리를 실행
- DB 접속 정보에서 **Show All Databases** 체크하고 재접속

#### 테이블 생성

- 아래의 코드 작성

```sql
-- 테이블 생성, 아까 creat table 창 열고 마우스로 설정하는 것을 손코딩
create table students(
	id int generated always as identity primary key, -- 학생 구분값 자동증가
	name varchar(50) not null, -- 이름 
	age int, -- 나이
	email varchar(100), -- 이메일
	created_at timestamp default current_timestamp -- 햔제 작성된 일자 시간
);
```

![](assets/20260915_150100_image.png)

![](assets/20260915_150131_image.png)

- 데이터 베이스 스키마를 현재 사용할 데이터베이스로 반드시 바꿔줘야 함!!!
- Ctrl + Enter로 확인!

#### 데이터 생성

- insert 쿼리(query: 질의(요청)하다. 데이터베이스에 요청)로 작성

```
insert into public.students (name, age, email)
values ('홍길동', 20, 'honggd@gmail.com');

insert into public.students (name, age, email)
values ('김동길', 21, 'kimdg@gmail.com'),
		('장동건', 21, 'qwer@gmail.com'),
		('홍명보', 21, '123@gmail.com'),
		('손흥민', 21, 'asd@gmail.com');
```

![](assets/20260915_151514_image.png)

바꾸고 Updated Rows 확인! 1이면 1건이 영향을 받았다.

- select 쿼리 작성 - 난이도가 올라감

```
-- 데이터 확인(SELECT)
select * from public.students;
```

- update 쿼리

```
-- 데이터 수정(UPDATE)
update students set
		email = 'hong@kakao.com'
where id = 1;
```

- delete 쿼리

```
-- 데이터 삭제(DELETE) (데이터 베이스는 '==' 쓰지 않음)
delete from students
	where name = '홍길동';
```

CRUD(★★★★★ 실무에서 아주 많이 씀) - Create, Read, Update, Delere 의 약자

- C - INSERT
- R - SELECT
- U - UPDATE
- D - DELETE

#### PostgreSQL 기본타입


| 데이터 타입 | 설명                          | 예제                       |
| ----------- | ----------------------------- | -------------------------- |
| INT         | 정수                          | 10, 25, -9                 |
| BIGINT      | 큰 정수                       | 10000000000000000000000000 |
| NUMERIC     | 정확한 소수                   | 120000.52                  |
| VARCHAR(n)  | 길이 제한 문자열(4000자 이하) | '홍길동'                   |
| TEXT        | 긴 문자열(1G)                 | 뉴스 게시물 본문           |
| BOOLEAN     | 참 또는 거짓                  | True, False                |
| DATE        | 날짜                          | 2026-09-15                 |
| TIMESTAMP   | 일자(날짜와 시간)             | 2026-09-15 16:00:20.456    |
| JSONB       | JSON 데이터                   | {"name" : "홍길동"}        |
