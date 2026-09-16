DROP TABLE IF EXISTS products;

CREATE TABLE products (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price INT NOT NULL,
    stock INT DEFAULT 0,
    category VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO products (name, price, stock, category)
VALUES
('키보드', 30000, 10, '컴퓨터주변기기'),
('마우스', 15000, 20, '컴퓨터주변기기'),
('모니터', 250000, 5, '디스플레이'),
('USB 메모리', 12000, 30, '저장장치'),
('노트북 거치대', 22000, 8, '액세서리'),
('웹캠', 45000, 12, '컴퓨터주변기기'),
('외장하드', 89000, 7, '저장장치'),
('노트북 파우치', 18000, 15, '액세서리'),
('HDMI 케이블', 9000, 40, '케이블'),
('무선 이어폰', 79000, 6, '음향기기');

--전체 상품을 조회하시오.
select * from products p;

--상품명과 가격만 조회하시오.(틀림)
select products.name, products.price from products;

--가격이 20000원 이상인 상품을 조회하시오.
select * from products p
	where p.price >= 20000;

--재고가 10개 이하인 상품을 조회하시오.
select * from products p
	where p.stock <= 10;

--가격이 높은 순서대로 정렬하시오.
select * from products p
	order by p.price desc;

--가장 비싼 상품 2개만 조회하시오.(틀림 desc 뒤 limit)
select * from products p
	order by p.price desc limit 2

--마우스의 가격을 18000원으로 수정하시오. (틀림)
update products p set 
	price = 18000
where p.name = '마우스';
	
--USB 메모리의 재고를 25개로 수정하시오. (값의 대소문자는 구분하는가?)
update products p set
	stock = 25
where p.name = 'USB 메모리';

--노트북 거치대 데이터를 삭제하시오.
delete from products p
	where p.name = '노트북 거치대';

--삭제 후 전체 상품을 다시 조회하시오.
select * from products p;