/* javascript 주석과 동일 */
-- 한 줄 주석

-- 데이터베이스 생성
create database ai_db;



-- 테이블 생성, 아까 creat table 창 열고 마우스로 설정하는 것을 손코딩
create table students(
	id int generated always as identity primary key, -- 학생 구분값 자동증가
	name varchar(50) not null, -- 이름 
	age int, -- 나이
	email varchar(100), -- 이메일
	created_at timestamp default current_timestamp -- 햔제 작성된 일자 시간
);

-- 아래부터는 쿼리를 반드시 알아야 함 !!!!!!!!!

-- 데이터 삽입(INSERT)
insert into public.students (name, age, email)
values ('홍길동', 20, 'honggd@gmail.com');

insert into public.students (name, age, email)
values ('김동길', 21, 'kimdg@gmail.com'),
		('장동건', 21, 'qwer@gmail.com'),
		('홍명보', 21, '123@gmail.com'),
		('손흥민', 21, 'asd@gmail.com');

-- 데이터 확인(SELECT)
select * from public.students;

-- 데이터 수정(UPDATE)
update students set
		email = 'hong@kakao.com'
where id = 1;

-- 데이터 삭제(DELETE) (데이터 베이스는 '==' 쓰지 않음)
delete from students
	where name = '홍길동';