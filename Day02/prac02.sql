-- 테이블 확인 (변경 사항이 없기 때문에 select는 Statistics가 안 나옴, 나머진 무조건 Updated Rows: 숫자 확인!)
select * from students s;

-- 테이블 완전 초기화 : 데이터 모두 삭제(다른 데이터 베이스에서는 truncate하면 1부터 시작 Postgres는 이전 숫자 사용 x)
truncate students;

-- 학생 정보 추가 쿼리(데이터 넣을 때는 별명을 잘 안씀)
-- 쿼리문법 문자열 무조건 ' ', 절대 " " 금지
insert into students(name, age, email)
values ('홍길동', 20, 'honggd@gmail.com');

-- 컬럼 순서 변경
insert into students (age, email, name)
values (29, 'gwonmg@gmail.com', '권민준');

insert into students(name, age, email)
values
('홍길순', 20, 'honggs@gmail.com'),
('홍길매', 20, 'honggm@gmail.com'),
('홍길자', 20, 'honggj@gmail.com');

insert into students(name, age, email)
values ('홍수와와와', 25, 'hong423d@gmail.com');

-- 전체 데이터 조회
select * from students s ;

-- 특정 컬럼만 조회
select age, name from students s ;

-- GUI로 구현한 쿼리, public -> Tables -> students 우클릭 -> SQL 생성
SELECT id, name, age, email, created_at
FROM public.students;

-- 필터링! 필요한 데이터만 조회(난이도 UP)
select * from students s 
where s.age < 25;

-- id 필터링
select * from students s 
where s.id  = 9;

-- 나이와 이름 일치 데이터 조회
select * from students s 
where s.age = 20
	and s. name = '홍길동';

-- 나이가 참이거나 이름이 참인 데이터 조회
select * from students s 
where s.age = 20
	or s. name = '홍길동';

-- 문자열에 해당 문자나 문자열이 존재하는 것만 조회

-- LIKE문 ▼
-- ~%: ~ 으로 시작하는 문자 다 출력
select * from students s
where s."name" like '홍%';

-- %~: ~ 으로 끝나는 문자 다 출력
select * from students s
where s."name" like '%순';

-- %~%: 이름 중간에 ~ 들어가는 문자 다 출력
select * from students s
where s."name" like '%민%';

-- 홍으로 시작하는데 글자 길이가 5자인 사람, 언더바로 글자 길이 제한. %는 필요 X 
select * from students s
where s."name" like '홍____';

-- Order by 정렬(order by: ~ 방식으로 정렬하다)
select * from students s
	order by "name" desc;

select * from students s
	order by age asc;

-- 나이는 오름차순, 이름은 내림차순으로 정렬
select * from students s
	order by age asc, "name" desc;

-- 조회수 제한
select * from students s
	order by id desc limit 3;