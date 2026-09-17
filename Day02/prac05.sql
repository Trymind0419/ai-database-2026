-- 학생 테이블 생성쿼리
create table students(
	id int generated always as identity primary key,
	name varchar(50) not null,
	age int,
	email varchar(100),
	created_at timestamp default current_timestamp 
);

-- 수강 테이블 생성쿼리
create table enrollments(
	id int generated always as identity primary key,
	students_id int not null, -- 수강하는 학생이 없으면 안됨.
	course_name varchar(100) not null, -- 과목명 없으면 안됨.
	enrolled_at timestamp default current_timestamp,
	constraint fk_enrollments_students -- 외래키에 대한 이름 fk_내테이블_상대테이블
		foreign key (students_id) -- 내 테이블에 있는 students_id를 fk로 하라.
		references students(id) -- students table(부모 테이블) 내 id 컬럼을 참조하라.
);

