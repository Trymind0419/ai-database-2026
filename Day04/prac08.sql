-- join 없이
select * from students s;

select * from courses c ;

select * from enrollments e ;

-- JOIN
select s.id "학생번호", s.name "학생이름", s.email "학생이메일", s.major "전공",
		e.id "수강번호", e.enrolled_at "수강일자", 
		c.id "과목번호", c.title "과목명", c.instructor "교강사명", c.hours "총시간"
from students s
inner join enrollments e
on s.id = e.student_id
inner join courses c 
on c.id = e.course_id ;

-- WHERE
select s.id "학생번호", s.name "학생이름", s.email "학생이메일", s.major "전공",
		e.id "수강번호", e.enrolled_at "수강일자", 
		c.id "과목번호", c.title "과목명", c.instructor "교강사명", c.hours "총시간"
from students s
inner join enrollments e
on s.id = e.student_id
inner join courses c 
on c.id = e.course_id
where c.hours >= 10 and s.id = 1;

-- 정렬
select s.id "학생번호", s.name "학생이름", s.email "학생이메일", s.major "전공",
		e.id "수강번호", e.enrolled_at "수강일자", 
		c.id "과목번호", c.title "과목명", c.instructor "교강사명", c.hours "총시간"
from students s
inner join enrollments e
on s.id = e.student_id
inner join courses c 
on c.id = e.course_id
order by s."name" desc, c.title asc;-- 기본이 asc / 쇼핑몰에서 가장 많이 활용되는 소스(높,낮 가격순)

-- 학생 추가
insert into students (name, email, age,major)
values ('주예찬','yeah@naver.com', 24, '인공지능'),
		('이찬혁','leeh@naver.com', 26, '임베디드');

select * from students s ;


-- OUTER JOIN
select * from students s left outer join enrollments e 
on s.id = e.student_id;

select * from students s 
	left outer join enrollments e 
		on s.id = e.student_id 
	left outer join courses c 
		on e.course_id = c.id
where e.id is null;


-- 집계함수
-- count()
select count(*) "학생수" from students s;

-- sum()
select sum(age) "학생나이합" from students s ;

-- 평균
select sum(age) / count(*) "평균나이" from students s ; -- 평균 나이 정수
select avg(age) "평균나이" from students s ; -- 평균 나이 실수

-- 최소나이
select min(age) "최소령자" from students s ;
--최고나이
select max(age) "최고령자" from students s ;

-- 그룹핑
select count(*) "학생수" from students s 
group by s.major;

-- 그룹핑 심화버전(전공별 학생수 집계 조회)
select count(*) "학생수", s.major "전공"
from students s 
group by s.major
order by s.major asc;

-- 잘못된 JOIN + GROUP BY
select (*) from courses c 
	inner join enrollments e
	on c.id = e.course_id
	group by c.title;

--
select count(*) "과목별 수강 수", c.title "과목"
	from courses c 
	inner join enrollments e
	on c.id = e.course_id
	group by c.title;

-- 트랜잭션 실습
drop table accounts;

create table accounts (
	account_id int primary key, -- 직접 입력해야함.
	owner_name varchar(50) not null,
	balance numeric(12, 0) not null check (balance >= 0)
)
commit;

-- 트랜잭션 시작(정석은 begin 먼저 실행 해놓고 쿼리 작성)
begin;

insert into accounts (account_id, owner_name, balance)
values (1, '김철수', 100000), (2, '박영희', 50000);

select * from accounts a ;

-- 확정/커밋 (하면 롤백 안함)
commit;
-- 취소/롤백 (하면 커밋 안함)
rollback;

-- 업데이트 트랜잭션
begin;

update accounts set
	balance = 1000000
where account_id =2;

commit;

rollback;

-- 딜리트 트랜잭션
begin;

delete from accounts; 

commit;

rollback;
