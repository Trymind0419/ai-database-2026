-- 학생 수강관리 시스템
DROP TABLE if exists "enrollments";
DROP TABLE if exists "courses";
DROP table if EXISTS "students";

CREATE TABLE "students" (
"id" int generated always as identity NOT NULL,
"name" varchar(50) NOT NULL,
"email" varchar(100) NULL,
"age" int NULL,
"major" varchar(50) NOT NULL,
"created_at" timestamp DEFAULT current_timestamp NULL
);

CREATE TABLE "courses" (
"id" int generated always as identity NOT NULL,
"title" varchar(100) NULL,
"instructor" varchar(50) NULL,
"hours" int NULL,
"created_at" timestamp DEFAULT current_timestamp NULL
);



CREATE TABLE "enrollments" (
"id" int generated always as identity NOT NULL,
"enrolled_at" timestamp DEFAULT current_timestamp NULL,
"student_id" int NOT NULL,
"course_id" int NOT NULL
);

ALTER TABLE "students" ADD CONSTRAINT "PK_STUDENTS" PRIMARY KEY (
"id"
);

ALTER TABLE "courses" ADD CONSTRAINT "PK_COURSES" PRIMARY KEY (
"id"
);

ALTER TABLE "enrollments" ADD CONSTRAINT "PK_ENROLLMENTS" PRIMARY KEY (
"id"
);

ALTER TABLE "enrollments" ADD CONSTRAINT "FK_students_TO_enrollments_1" FOREIGN KEY (
"student_id"
)
REFERENCES "students" (
"id"
);

ALTER TABLE "enrollments" ADD CONSTRAINT "FK_courses_TO_enrollments_1" FOREIGN KEY (
"course_id"
)
REFERENCES "courses" (
"id"
);


-- 학생 데이터 입력
INSERT INTO students (name, email, age, major)
VALUES
('김철수', 'kim@example.com', 21, '인공지능'),
('이영희', 'lee@example.com', 22, '데이터분석'),
('박민수', 'park@example.com', 23, '웹개발'),
('최지훈', 'choi@example.com', 24, '임베디드'),
('정수빈', 'jung@example.com', 20, '클라우드');

-- 과목 데이터 입력
INSERT INTO courses (title, instructor, hours)
VALUES
('PostgreSQL 기본', '성명건', 8),
('FastAPI 서버 개발', '성명건', 12),
('데이터 분석 기초', '성명건', 10);

-- 수강 데이터 입력
INSERT INTO enrollments (student_id, course_id)
VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 2),
(4, 3),
(5, 1);