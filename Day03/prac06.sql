-- 현재 테이블 확인 - pg_tables : Postgres 가 생성한 시스템 테이블. 현재 있는 테이블 다 있음
select * from pg_tables;

select * from students s ;

-- 테이블 컬럼 사이즈 수정
alter table students
alter column email type varchar(150);

-- 데이터 삽입
insert into students (age, major)
values (23, '경영학과');

-- 같은 이메일 입력 불가 제약조건
insert into students (name, age, email, major)
values ('홍홍홍', 23, 'poijiuni@gmaip.com', '정치학과');

-- 학생 학년 모두 4로 수정(check 제약조건 X)
update students s set
	grade = 88
where id = 1;

-- CHECK 제약 조건 추가 후 새학생 추가
insert into students (name, email, major, grade)
values ('아미고', 'amigo@gmail.com', '사학과', 3);

-- 상품 추가 쿼리
insert into products (name, price, category)
values ('아이폰', 1600000, '전자제품');

-- 상품 추가 쿼리
insert into products (name, price)
values ('갤럭시s26', 1200000);