-- ERD 프로그램으로 만듦
DROP TABLE "students";

CREATE TABLE "students" (
	"id"	int generated always as identity primary key,
	"name"	varchar(50)		NULL,
	"email"	varchar(100)		NULL,
	"age"	int		NULL,
	"major"	varchar(50)		NOT NULL,
	"current_at"	timestamp	DEFAULT current_timestamp	NULL
);