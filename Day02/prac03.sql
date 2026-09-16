-- UPDATE
select * from students s;


-- 홍길순의 나이를 변경(where 없이 하면 다 age 60으로 바뀜)
update students s set
	age = 60
where name = '홍길순';

-- 이러지마세요
update students s set
	age = 60;

-- DELETE
-- id 7번 삭제
delete from students 
	where id = 7;

-- 이러지마세요
delete from students;

-- 논외. 테이블 삭제
drop table students ;


-- 테이블 생성
create table students (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, -- 기본키(PK) - 중복 안되고 NOT NULL ★★★★★
	name VARCHAR(50) NOT NULL, -- 이름은 NULL이 될 수 없다. (이름은 중복이 가능해서 PK 불가)
	age INT, -- 나이 NULL
	email VARCHAR(100), -- 이메일 NULL
	major VARCHAR(50), -- 전공 NULL
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- NULL 
);

-- 데이터 조회
select * from students s ;

-- 데이터 추가
insert into students (name, age, email, major)
values ('홍길동', 20, 'hong@gmail.com', '컴퓨터공학');

-- 전공을 null
insert into students (name, age, email, major)
values ('성유고', 21, 'hong@gmail.com', null);

insert into students (name, age, email, major)
values ('성미나', null, 'seong@gmail.com', null);

insert into students ("name" )
values ('성미나');

insert into students (name, age, email, major)
values (NULL, null, 'seong@gmail.com', null);

insert into students (name, age, email)
values ('애슐리', 26, 'QWER@gmail.com');


-- 이메일을 입력하지 않은 사용자를 조회
select * from students s
	where s.email is null; -- where s.email = null 조회 불가
	
select * from students s
	where s.email is not null;

select * from students s
	where s.name != '성미나';