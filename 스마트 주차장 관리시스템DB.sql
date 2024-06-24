-- 스마트 주차장 관리 시스템 데이터베이스 구축
CREATE database smart_parking;

-- 미리 생성한 parking스키마 테이블 삭제
DROP TABLE IF EXISTS USERS;
DROP TABLE IF EXISTS CAR;
DROP TABLE IF EXISTS MANAGER;
DROP TABLE IF EXISTS PARKING;
DROP TABLE IF EXISTS SPOT;
DROP TABLE IF EXISTS RESERVATION;
DROP TABLE IF EXISTS VISIT;
DROP TABLE IF EXISTS DISCOUNT;
DROP TABLE IF EXISTS CHARGE;
DROP TABLE IF EXISTS PAY;

-- smart_parking DB 사용
use smart_parking;

-- USERS 테이블 생성 및 확인
CREATE TABLE USERS(
user_id VARCHAR(10) NOT NULL,
user_name VARCHAR(10),
user_address VARCHAR(30),
user_phone VARCHAR(20),
PRIMARY KEY(user_id)
);

SELECT * FROM USERS;

-- CAR 테이블 생성 및 확인
CREATE TABLE CAR(
car_num INTEGER NOT NULL,
car_type VARCHAR(5),
user_id VARCHAR(10) NOT NULL,
PRIMARY KEY(car_num,user_id),
FOREIGN KEY(user_id) REFERENCES USERS(user_id)
);

SELECT * FROM CAR;

-- MANAGER 테이블 생성 및 확인
CREATE TABLE MANAGER(
manager_id VARCHAR(4) NOT NULL,
manager_name VARCHAR(10),
manager_phone VARCHAR(20),
manager_address VARCHAR(30),
PRIMARY KEY(manager_id)
);

SELECT * FROM MANAGER;

-- PARKING 테이블 생성 및 확인
CREATE TABLE PARKING(
parking_id VARCHAR(10) NOT NULL,
parking_location VARCHAR(50),
parking_pay INTEGER,
manager_id VARCHAR(4),
PRIMARY KEY(parking_id),
FOREIGN KEY(manager_id) REFERENCES MANAGER(manager_id)
);

SELECT * FROM PARKING;

-- SPOT 테이블 생성 및 확인
CREATE TABLE SPOT(
spot_num INTEGER NOT NULL,
spot_type VARCHAR(8),
parking_id VARCHAR(10),
PRIMARY KEY(spot_num, parking_id),
FOREIGN KEY(parking_id) REFERENCES PARKING(parking_id)
);

SELECT * FROM SPOT;

-- RESERVATION 테이블 생성 및 확인
CREATE TABLE RESERVATION(
reservation_num INTEGER NOT NULL,
reservation_date DATE,
reservation_time TIME,
reservation_status VARCHAR(5),
user_id VARCHAR(10) NOT NULL,
spot_num INTEGER NOT NULL,
parking_id VARCHAR(10) NOT NULL,
PRIMARY KEY(reservation_num),
FOREIGN KEY(user_id) REFERENCES USERS(user_id),
FOREIGN KEY(spot_num) REFERENCES SPOT(spot_num),
FOREIGN KEY(parking_id) REFERENCES PARKING(parking_id)
);

SELECT * FROM RESERVATION;

-- VISIT 테이블 생성 및 확인
CREATE TABLE VISIT(
visit_num INTEGER NOT NULL,
visit_date DATE,
visit_start TIME,
visit_finish TIME,
user_id VARCHAR(10) NOT NULL,
spot_num INTEGER NOT NULL,
parking_id VARCHAR(10) NOT NULL,
PRIMARY KEY(visit_num),
FOREIGN KEY(user_id) REFERENCES USERS(user_id),
FOREIGN KEY(spot_num) REFERENCES SPOT(spot_num),
FOREIGN KEY(parking_id) REFERENCES PARKING(parking_id)
);

SELECT * FROM VISIT;

-- DISCOUNT 테이블 생성 및 확인
CREATE TABLE DISCOUNT(
discount_code VARCHAR(10) NOT NULL,
discount_money INTEGER,
discount_d VARCHAR(100),
PRIMARY KEY(discount_code)
);

SELECT * FROM DISCOUNT;

-- CHARGE 테이블 생성 및 확인
CREATE TABLE CHARGE(
charge_sum INTEGER NOT NULL,
visit_num INTEGER NOT NULL,
discount_code VARCHAR(10),
PRIMARY KEY(charge_sum,visit_num),
FOREIGN KEY(visit_num) REFERENCES VISIT(visit_num),
FOREIGN KEY(discount_code) REFERENCES DISCOUNT(discount_code)
);

SELECT * FROM CHARGE;

-- PAY 테이블 생성 및 확인
CREATE TABLE PAY(
pay_num INTEGER NOT NULL,
pay_date DATETIME,
pay_type VARCHAR(5),
pay_money INTEGER NOT NULL,
user_id VARCHAR(10) NOT NULL,
visit_num INTEGER NOT NULL,
PRIMARY KEY(pay_num),
FOREIGN KEY(pay_money) REFERENCES CHARGE(charge_sum),
FOREIGN KEY(user_id) REFERENCES USERS(user_id),
FOREIGN KEY(visit_num) REFERENCES VISIT(visit_num)
);

SELECT * FROM PAY;


-- USERS 테이블 데이터 입력 및 조회
INSERT INTO USERS VALUES ('user01', '김지한', '서울시 강남구 역삼동 123번지', '010-1234-5678');
INSERT INTO USERS VALUES ('user02', '박서준', '서울시 서초구 반포동 456번지', '010-2345-6789');
INSERT INTO USERS VALUES ('user03', '이지훈', '서울시 송파구 잠실동 789번지', '010-3456-7890');
INSERT INTO USERS VALUES ('user04', '최지우', '서울시 강서구 화곡동 101번지', '010-4567-8901');
INSERT INTO USERS VALUES ('user05', '정예린', '서울시 동작구 사당동 202번지', '010-5678-9012');
INSERT INTO USERS VALUES ('user06', '김민호', '서울시 마포구 서교동 303번지', '010-6789-0123');
INSERT INTO USERS VALUES ('user07', '송하윤', '서울시 종로구 사직동 404번지', '010-7890-1234');
INSERT INTO USERS VALUES ('user08', '방성우', '서울시 성북구 동선동 505번지', '010-8901-2345');
INSERT INTO USERS VALUES ('user09', '윤지민', '서울시 강북구 미아동 606번지', '010-9012-3456');
INSERT INTO USERS VALUES ('user10', '이승현', '서울시 강동구 천호동 707번지', '010-0123-4567');
INSERT INTO USERS VALUES ('user11', '김태연', '서울시 송파구 가락동 808번지', '010-1234-5678');
INSERT INTO USERS VALUES ('user12', '정지후', '서울시 강남구 신사동 909번지', '010-2345-6789');
INSERT INTO USERS VALUES ('user13', '장세은', '서울시 서초구 잠원동 111번지', '010-3456-7890');
INSERT INTO USERS VALUES ('user14', '이수민', '서울시 강서구 방화동 222번지', '010-4567-8901');
INSERT INTO USERS VALUES ('user15', '손유진', '서울시 강북구 번동 333번지', '010-5678-9012');
INSERT INTO USERS VALUES ('user16', '김준서', '서울시 양천구 목동 444번지', '010-6789-0123');
INSERT INTO USERS VALUES ('user17', '배수현', '서울시 강남구 역삼동 555번지', '010-7890-2345');
INSERT INTO USERS VALUES ('user18', '이지원', '서울시 성동구 성수동 666번지', '010-8901-3456');
INSERT INTO USERS VALUES ('user19', '신지민', '서울시 중구 회현동 777번지', '010-9012-4567');
INSERT INTO USERS VALUES ('user20', '최예은', '서울시 송파구 잠실동 888번지', '010-0123-5678');
INSERT INTO USERS VALUES ('user21', '김동하', '서울시 강서구 화곡동 999번지', '010-1234-6789');
INSERT INTO USERS VALUES ('user22', '박시우', '서울시 관악구 봉천동 100번지', '010-2345-7890');
INSERT INTO USERS VALUES ('user23', '이가은', '서울시 강동구 천호동 200번지', '010-3456-8901');
INSERT INTO USERS VALUES ('user24', '김태호', '서울시 구로구 구로동 300번지', '010-4567-9012');
INSERT INTO USERS VALUES ('user25', '정다은', '서울시 강남구 신사동 400번지', '010-5678-0123');
INSERT INTO USERS VALUES ('user26', '방성호', '서울시 서초구 반포동 500번지', '010-6789-1234');
INSERT INTO USERS VALUES ('user27', '이서준', '서울시 도봉구 방학동 600번지', '010-7890-2345');
INSERT INTO USERS VALUES ('user28', '송민재', '서울시 강서구 내발산동 700번지', '010-8901-3456');
INSERT INTO USERS VALUES ('user29', '김현우', '서울시 서대문구 창천동 800번지', '010-9012-4567');
INSERT INTO USERS VALUES ('user30', '신소희', '서울시 마포구 합정동 900번지', '010-0123-5678');

SELECT * FROM USERS;

-- CAR 테이블 데이터 입력 및 조회
INSERT INTO CAR VALUES (1001, '승용차', 'user01');
INSERT INTO CAR VALUES (1002, 'SUV', 'user02');
INSERT INTO CAR VALUES (1003, '트럭', 'user03');
INSERT INTO CAR VALUES (1004, '승용차', 'user04');
INSERT INTO CAR VALUES (1005, 'SUV', 'user01');
INSERT INTO CAR VALUES (1006, '트럭', 'user06');
INSERT INTO CAR VALUES (1007, '승용차', 'user07');
INSERT INTO CAR VALUES (1008, 'SUV', 'user08');
INSERT INTO CAR VALUES (1009, '트럭', 'user09');
INSERT INTO CAR VALUES (1010, '승용차', 'user10');
INSERT INTO CAR VALUES (1011, 'SUV', 'user11');
INSERT INTO CAR VALUES (1012, '트럭', 'user11');
INSERT INTO CAR VALUES (1013, '승용차', 'user13');
INSERT INTO CAR VALUES (1014, 'SUV', 'user14');
INSERT INTO CAR VALUES (1015, '트럭', 'user15');
INSERT INTO CAR VALUES (1016, '승용차', 'user16');
INSERT INTO CAR VALUES (1017, 'SUV', 'user17');
INSERT INTO CAR VALUES (1018, '트럭', 'user18');
INSERT INTO CAR VALUES (1019, '승용차', 'user19');
INSERT INTO CAR VALUES (1020, 'SUV', 'user20');
INSERT INTO CAR VALUES (1021, '트럭', 'user21');
INSERT INTO CAR VALUES (1022, '승용차', 'user22');
INSERT INTO CAR VALUES (1023, 'SUV', 'user22');
INSERT INTO CAR VALUES (1024, '트럭', 'user22');
INSERT INTO CAR VALUES (1025, '승용차', 'user25');
INSERT INTO CAR VALUES (1026, 'SUV', 'user26');
INSERT INTO CAR VALUES (1027, '트럭', 'user27');
INSERT INTO CAR VALUES (1028, '승용차', 'user28');
INSERT INTO CAR VALUES (1029, 'SUV', 'user29');
INSERT INTO CAR VALUES (1030, '트럭', 'user30');

SELECT * FROM CAR;

-- MANAGER 테이블 데이터 입력 및 조회
INSERT INTO MANAGER VALUES ('m101', '김영수', '010-6789-1234', '부산시 해운대구 우동 111번지');
INSERT INTO MANAGER VALUES ('m102', '박종필', '010-7890-2345', '대구시 중구 삼덕동 222번지');
INSERT INTO MANAGER VALUES ('m103', '이정호', '010-8901-3456', '인천시 남동구 구월동 333번지');
INSERT INTO MANAGER VALUES ('m104', '최영자', '010-9012-4567', '광주시 서구 용봉동 444번지');
INSERT INTO MANAGER VALUES ('m105', '정은영', '010-0123-5678', '대전시 중구 은행동 555번지');
INSERT INTO MANAGER VALUES ('m106', '박영식', '010-1234-6789', '울산시 남구 삼산동 666번지');
INSERT INTO MANAGER VALUES ('m107', '이정희', '010-2345-7890', '세종시 한솔동 777번지');
INSERT INTO MANAGER VALUES ('m108', '장영순', '010-3456-8901', '경기도 수원시 장안구 영화동 888번지');
INSERT INTO MANAGER VALUES ('m109', '오종훈', '010-4567-0123', '강원도 춘천시 석사동 999번지');
INSERT INTO MANAGER VALUES ('m110', '이승환', '010-5678-2345', '충청북도 청주시 흥덕구 가경동 000번지');
INSERT INTO MANAGER VALUES ('m111', '박성훈', '010-6789-3456', '전라북도 전주시 완산구 중화산동 111번지');
INSERT INTO MANAGER VALUES ('m112', '김종현', '010-7890-4567', '전라남도 목포시 용당동 222번지');
INSERT INTO MANAGER VALUES ('m113', '정형준', '010-8901-5678', '경상북도 포항시 남구 해도동 333번지');
INSERT INTO MANAGER VALUES ('m114', '박민수', '010-9012-6789', '경상남도 창원시 의창구 동읍동 444번지');
INSERT INTO MANAGER VALUES ('m115', '이지훈', '010-0123-7890', '제주특별자치도 제주시 이도이동 555번지');
INSERT INTO MANAGER VALUES ('m116', '김승우', '010-1234-8901', '경기도 안양시 동안구 관양동 666번지');
INSERT INTO MANAGER VALUES ('m117', '장태우', '010-2345-0123', '경기도 고양시 일산동구 정발산동 777번지');
INSERT INTO MANAGER VALUES ('m118', '신동엽', '010-3456-1234', '경기도 성남시 분당구 정자동 888번지');
INSERT INTO MANAGER VALUES ('m119', '이기광', '010-4567-2345', '서울시 강북구 번동 999번지');
INSERT INTO MANAGER VALUES ('m120', '윤여정', '010-5678-3456', '서울시 강동구 천호동 000번지');
INSERT INTO MANAGER VALUES ('m121', '김래원', '010-6789-4567', '서울시 송파구 잠실동 111번지');
INSERT INTO MANAGER VALUES ('m122', '전소민', '010-7890-5678', '서울시 서초구 반포동 222번지');
INSERT INTO MANAGER VALUES ('m123', '정지소', '010-8901-6789', '서울시 동작구 사당동 333번지');
INSERT INTO MANAGER VALUES ('m124', '신동엽', '010-9012-7890', '서울시 강서구 화곡동 444번지');
INSERT INTO MANAGER VALUES ('m125', '김기용', '010-0123-8901', '서울시 마포구 서교동 555번지');
INSERT INTO MANAGER VALUES ('m126', '윤여정', '010-1234-0123', '서울시 성북구 동선동 666번지');
INSERT INTO MANAGER VALUES ('m127', '전소민', '010-2345-1234', '서울시 종로구 사직동 777번지');
INSERT INTO MANAGER VALUES ('m128', '정지소', '010-3456-2345', '서울시 강남구 역삼동 888번지');
INSERT INTO MANAGER VALUES ('m129', '이민호', '010-4567-3456', '서울시 중구 회현동 999번지');
INSERT INTO MANAGER VALUES ('m130', '김래원', '010-5678-4567', '서울시 용산구 이태원동 000번지');

SELECT * FROM MANAGER;

-- PARKING 테이블 데이터 입력 및 조회
INSERT INTO PARKING VALUES ('Parking001', '서울 강남구 역삼동', 10000, 'm101');
INSERT INTO PARKING VALUES ('Parking002', '서울 서초구 반포동', 15000, 'm102');
INSERT INTO PARKING VALUES ('Parking003', '서울 송파구 잠실동', 12000, 'm103');
INSERT INTO PARKING VALUES ('Parking004', '서울 강서구 화곡동', 13000, 'm104');
INSERT INTO PARKING VALUES ('Parking005', '서울 동작구 사당동', 11000, 'm104');
INSERT INTO PARKING VALUES ('Parking006', '서울 마포구 서교동', 20000, 'm106');
INSERT INTO PARKING VALUES ('Parking007', '서울 종로구 사직동', 25000, 'm107');
INSERT INTO PARKING VALUES ('Parking008', '서울 성북구 동선동', 18000, 'm110');
INSERT INTO PARKING VALUES ('Parking009', '서울 강북구 번동', 17000, 'm109');
INSERT INTO PARKING VALUES ('Parking010', '서울 강동구 천호동', 16000, 'm110');
INSERT INTO PARKING VALUES ('Parking011', '서울 송파구 잠실동', 14000, 'm111');
INSERT INTO PARKING VALUES ('Parking012', '서울 서초구 반포동', 30000, 'm117');
INSERT INTO PARKING VALUES ('Parking013', '서울 강남구 역삼동', 25000, 'm113');
INSERT INTO PARKING VALUES ('Parking014', '서울 마포구 서교동', 18000, 'm114');
INSERT INTO PARKING VALUES ('Parking015', '서울 성동구 성수동', 20000, 'm115');
INSERT INTO PARKING VALUES ('Parking016', '서울 강서구 화곡동', 15000, 'm116');
INSERT INTO PARKING VALUES ('Parking017', '서울 강남구 삼성동', 28000, 'm117');
INSERT INTO PARKING VALUES ('Parking018', '서울 서초구 서초동', 22000, 'm117');
INSERT INTO PARKING VALUES ('Parking019', '서울 강북구 미아동', 17000, 'm119');
INSERT INTO PARKING VALUES ('Parking020', '서울 송파구 잠실동', 19000, 'm120');
INSERT INTO PARKING VALUES ('Parking021', '서울 마포구 합정동', 21000, 'm127');
INSERT INTO PARKING VALUES ('Parking022', '서울 종로구 종로동', 24000, 'm122');
INSERT INTO PARKING VALUES ('Parking023', '서울 강남구 신사동', 26000, 'm123');
INSERT INTO PARKING VALUES ('Parking024', '서울 강서구 마곡동', 23000, 'm124');
INSERT INTO PARKING VALUES ('Parking025', '서울 서초구 방배동', 27000, 'm125');
INSERT INTO PARKING VALUES ('Parking026', '서울 강북구 번동', 14000, 'm126');
INSERT INTO PARKING VALUES ('Parking027', '서울 강남구 역삼동', 18000, 'm127');
INSERT INTO PARKING VALUES ('Parking028', '서울 송파구 잠실동', 16000, 'm128');
INSERT INTO PARKING VALUES ('Parking029', '서울 마포구 망원동', 17000, 'm130');
INSERT INTO PARKING VALUES ('Parking030', '서울 강서구 등촌동', 19000, 'm130');

SELECT * FROM PARKING;

-- SPOT 테이블 데이터 입력 및 조회
INSERT INTO SPOT VALUES (1, '일반 차량', 'Parking001');
INSERT INTO SPOT VALUES (2, '전기차 전용', 'Parking001');
INSERT INTO SPOT VALUES (3, '장애인 전용', 'Parking001');
INSERT INTO SPOT VALUES (4, '일반 차량', 'Parking001');
INSERT INTO SPOT VALUES (5, '일반 차량', 'Parking002');
INSERT INTO SPOT VALUES (6, '전기차 전용', 'Parking002');
INSERT INTO SPOT VALUES (7, '일반 차량', 'Parking005');
INSERT INTO SPOT VALUES (8, '장애인 전용', 'Parking030');
INSERT INTO SPOT VALUES (9, '일반 차량', 'Parking030');
INSERT INTO SPOT VALUES (10, '일반 차량', 'Parking029');
INSERT INTO SPOT VALUES (11, '일반 차량', 'Parking004');
INSERT INTO SPOT VALUES (12, '전기차 전용', 'Parking004');
INSERT INTO SPOT VALUES (13, '일반 차량', 'Parking005');
INSERT INTO SPOT VALUES (14, '전기차 전용', 'Parking005');
INSERT INTO SPOT VALUES (15, '장애인 전용', 'Parking005');
INSERT INTO SPOT VALUES (16, '일반 차량', 'Parking006');
INSERT INTO SPOT VALUES (17, '일반 차량', 'Parking006');
INSERT INTO SPOT VALUES (18, '전기차 전용', 'Parking006');
INSERT INTO SPOT VALUES (19, '일반 차량', 'Parking027');
INSERT INTO SPOT VALUES (20, '일반 차량', 'Parking007');
INSERT INTO SPOT VALUES (21, '장애인 전용', 'Parking007');
INSERT INTO SPOT VALUES (22, '일반 차량', 'Parking008');
INSERT INTO SPOT VALUES (23, '일반 차량', 'Parking008');
INSERT INTO SPOT VALUES (24, '전기차 전용', 'Parking008');
INSERT INTO SPOT VALUES (25, '일반 차량', 'Parking009');
INSERT INTO SPOT VALUES (26, '전기차 전용', 'Parking009');
INSERT INTO SPOT VALUES (27, '장애인 전용', 'Parking009');
INSERT INTO SPOT VALUES (28, '일반 차량', 'Parking011');
INSERT INTO SPOT VALUES (29, '일반 차량', 'Parking010');
INSERT INTO SPOT VALUES (30, '일반 차량', 'Parking010');
INSERT INTO SPOT VALUES (31, '일반 차량', 'Parking015');
INSERT INTO SPOT VALUES (32, '전기차 전용', 'Parking028');
INSERT INTO SPOT VALUES (33, '장애인 전용', 'Parking001');
INSERT INTO SPOT VALUES (34, '일반 차량', 'Parking002');
INSERT INTO SPOT VALUES (35, '일반 차량', 'Parking022');
INSERT INTO SPOT VALUES (36, '전기차 전용', 'Parking002');
INSERT INTO SPOT VALUES (37, '일반 차량', 'Parking003');
INSERT INTO SPOT VALUES (38, '장애인 전용', 'Parking003');
INSERT INTO SPOT VALUES (39, '일반 차량', 'Parking003');
INSERT INTO SPOT VALUES (40, '일반 차량', 'Parking004');
INSERT INTO SPOT VALUES (41, '일반 차량', 'Parking004');
INSERT INTO SPOT VALUES (42, '전기차 전용', 'Parking004');
INSERT INTO SPOT VALUES (43, '일반 차량', 'Parking005');
INSERT INTO SPOT VALUES (44, '전기차 전용', 'Parking005');
INSERT INTO SPOT VALUES (45, '장애인 전용', 'Parking005');
INSERT INTO SPOT VALUES (46, '일반 차량', 'Parking026');
INSERT INTO SPOT VALUES (47, '일반 차량', 'Parking024');
INSERT INTO SPOT VALUES (48, '전기차 전용', 'Parking006');
INSERT INTO SPOT VALUES (49, '일반 차량', 'Parking007');
INSERT INTO SPOT VALUES (50, '일반 차량', 'Parking007');
INSERT INTO SPOT VALUES (51, '장애인 전용', 'Parking007');
INSERT INTO SPOT VALUES (52, '일반 차량', 'Parking018');
INSERT INTO SPOT VALUES (53, '일반 차량', 'Parking008');
INSERT INTO SPOT VALUES (54, '전기차 전용', 'Parking030');
INSERT INTO SPOT VALUES (55, '일반 차량', 'Parking030');
INSERT INTO SPOT VALUES (56, '전기차 전용', 'Parking029');
INSERT INTO SPOT VALUES (57, '장애인 전용', 'Parking009');
INSERT INTO SPOT VALUES (58, '일반 차량', 'Parking010');
INSERT INTO SPOT VALUES (59, '일반 차량', 'Parking010');
INSERT INTO SPOT VALUES (60, '일반 차량', 'Parking011');

SELECT * FROM SPOT;

-- RESERVATION 데이터 입력 및 조회
INSERT INTO RESERVATION VALUES (1000001, '2024-07-01', '10:00:00', 'y', 'user01', 1, 'Parking001');
INSERT INTO RESERVATION VALUES (1000002, '2024-07-02', '15:30:00', 'y', 'user02', 4, 'Parking001');
INSERT INTO RESERVATION VALUES (1000003, '2024-07-03', '14:00:00', 'y', 'user03', 7, 'Parking005');
INSERT INTO RESERVATION VALUES (1000004, '2024-07-04', '11:45:00', 'n', 'user04', 8, 'Parking030');
INSERT INTO RESERVATION VALUES (1000005, '2024-07-07', '09:30:00', 'y', 'user05', 10, 'Parking029');
INSERT INTO RESERVATION VALUES (1000006, '2024-07-07', '16:20:00', 'y', 'user06', 12, 'Parking004');
INSERT INTO RESERVATION VALUES (1000007, '2024-07-07', '13:15:00', 'n', 'user07', 15, 'Parking005');
INSERT INTO RESERVATION VALUES (1000008, '2024-07-08', '18:00:00', 'y', 'user08', 17, 'Parking006');
INSERT INTO RESERVATION VALUES (1000009, '2024-07-09', '10:45:00', 'y', 'user09', 19, 'Parking027');
INSERT INTO RESERVATION VALUES (1000010, '2024-07-10', '12:30:00', 'y', 'user10', 20, 'Parking007');
INSERT INTO RESERVATION VALUES (1000011, '2024-07-11', '09:00:00', 'n', 'user11', 21, 'Parking007');
INSERT INTO RESERVATION VALUES (1000012, '2024-07-11', '15:00:00', 'y', 'user12', 23, 'Parking008');
INSERT INTO RESERVATION VALUES (1000013, '2024-07-13', '17:45:00', 'y', 'user13', 25, 'Parking009');
INSERT INTO RESERVATION VALUES (1000014, '2024-07-14', '14:30:00', 'n', 'user14', 28, 'Parking011');
INSERT INTO RESERVATION VALUES (1000015, '2024-07-15', '10:15:00', 'y', 'user15', 30, 'Parking010');
INSERT INTO RESERVATION VALUES (1000016, '2024-07-16', '11:00:00', 'y', 'user16', 33, 'Parking001');
INSERT INTO RESERVATION VALUES (1000017, '2024-07-17', '08:45:00', 'y', 'user17', 36, 'Parking002');
INSERT INTO RESERVATION VALUES (1000018, '2024-07-19', '16:30:00', 'n', 'user18', 38, 'Parking003');
INSERT INTO RESERVATION VALUES (1000019, '2024-07-19', '13:20:00', 'y', 'user19', 40, 'Parking004');
INSERT INTO RESERVATION VALUES (1000020, '2024-07-20', '10:10:00', 'y', 'user20', 43, 'Parking005');
INSERT INTO RESERVATION VALUES (1000021, '2024-07-20', '12:45:00', 'n', 'user21', 46, 'Parking026');
INSERT INTO RESERVATION VALUES (1000022, '2024-07-20', '14:50:00', 'y', 'user22', 49, 'Parking007');
INSERT INTO RESERVATION VALUES (1000023, '2024-07-20', '09:35:00', 'y', 'user23', 51, 'Parking007');
INSERT INTO RESERVATION VALUES (1000024, '2024-07-20', '11:20:00', 'y', 'user24', 53, 'Parking008');
INSERT INTO RESERVATION VALUES (1000025, '2024-07-25', '17:00:00', 'n', 'user25', 56, 'Parking029');
INSERT INTO RESERVATION VALUES (1000026, '2024-07-25', '10:55:00', 'y', 'user26', 57, 'Parking009');
INSERT INTO RESERVATION VALUES (1000027, '2024-07-27', '13:40:00', 'y', 'user27', 59, 'Parking010');
INSERT INTO RESERVATION VALUES (1000028, '2024-07-28', '15:25:00', 'y', 'user28', 60, 'Parking011');

SELECT * FROM RESERVATION;

-- VISIT 데이터 입력 및 조회
INSERT INTO VISIT VALUES (100000001,'2024-07-01','10:00:00','11:30:00','user01',1,'Parking001');
INSERT INTO VISIT VALUES (100000002,'2024-07-02','15:30:00','17:00:00','user02',4,'Parking001');
INSERT INTO VISIT VALUES (100000003,'2024-07-03','14:00:00','15:30:00','user03',7,'Parking005');
INSERT INTO VISIT VALUES (100000004,'2024-07-04','11:45:00','13:15:00','user04',8,'Parking030');
INSERT INTO VISIT VALUES (100000005,'2024-07-05','09:30:00','11:00:00','user05',10,'Parking029');
INSERT INTO VISIT VALUES (100000006,'2024-07-06','16:20:00','17:50:00','user06',12,'Parking004');
INSERT INTO VISIT VALUES (100000007,'2024-07-07','13:15:00','14:45:00','user07',15,'Parking005');
INSERT INTO VISIT VALUES (100000008,'2024-07-08','18:00:00','19:30:00','user08',17,'Parking006');
INSERT INTO VISIT VALUES (100000009,'2024-07-09','10:45:00','12:15:00','user09',19,'Parking027');
INSERT INTO VISIT VALUES (100000010,'2024-07-10','12:30:00','14:00:00','user10',20,'Parking007');
INSERT INTO VISIT VALUES (100000011,'2024-07-11','09:00:00','10:30:00','user11',21,'Parking007');
INSERT INTO VISIT VALUES (100000012,'2024-07-12','15:00:00','16:30:00','user12',23,'Parking008');
INSERT INTO VISIT VALUES (100000013,'2024-07-13','17:45:00','19:15:00','user13',25,'Parking009');
INSERT INTO VISIT VALUES (100000014,'2024-07-13','18:00:00','19:15:00','user13',8,'Parking030');
INSERT INTO VISIT VALUES (100000015,'2024-07-14','14:30:00','16:00:00','user14',28,'Parking011');
INSERT INTO VISIT VALUES (100000016,'2024-07-16','11:00:00','12:30:00','user16',33,'Parking001');
INSERT INTO VISIT VALUES (100000017,'2024-07-17','08:45:00','10:15:00','user17',36,'Parking002');
INSERT INTO VISIT VALUES (100000018,'2024-07-19','13:20:00','14:50:00','user17',15,'Parking005');
INSERT INTO VISIT VALUES (100000019,'2024-07-19','15:00:00','16:50:00','user30',15,'Parking005');
INSERT INTO VISIT VALUES (100000020,'2024-07-20','10:10:00','11:40:00','user20',43,'Parking005');
INSERT INTO VISIT VALUES (100000021,'2024-07-21','12:45:00','14:15:00','user21',46,'Parking026');
INSERT INTO VISIT VALUES (100000022,'2024-07-22','14:50:00','16:20:00','user22',49,'Parking007');
INSERT INTO VISIT VALUES (100000023,'2024-07-23','09:35:00','11:05:00','user23',51,'Parking007');
INSERT INTO VISIT VALUES (100000024,'2024-07-25','11:20:00','12:50:00','user24',57,'Parking029');
INSERT INTO VISIT VALUES (100000025,'2024-07-25','17:00:00','18:30:00','user25',56,'Parking029');
INSERT INTO VISIT VALUES (100000026,'2024-07-26','10:55:00','12:25:00','user26',57,'Parking009');
INSERT INTO VISIT VALUES (100000027,'2024-07-27','13:40:00','15:10:00','user27',59,'Parking010');
INSERT INTO VISIT VALUES (100000028,'2024-08-08','20:00:00','21:30:00','user09',17,'Parking006');
INSERT INTO VISIT VALUES (100000029,'2024-08-15','15:25:00','16:55:00','user28',60,'Parking011');
INSERT INTO VISIT VALUES (100000030,'2024-08-20','14:30:00','16:00:00','user14',28,'Parking011');

SELECT * FROM VISIT;

-- DISCOUNT 데이터 입력 및 조회
INSERT INTO DISCOUNT VALUES ('FIRST', 5000, '첫 방문 고객에게 적용되는 할인');
INSERT INTO DISCOUNT VALUES ('SUMMER', 3000, '여름 세일 행사 할인');
INSERT INTO DISCOUNT VALUES ('WEEKEND20', 2000, '주말에 이용 시 20% 할인');
INSERT INTO DISCOUNT VALUES ('SPRING24', 7000, '2024년 봄철 한정 특별 할인');
INSERT INTO DISCOUNT VALUES ('LOYALTY10', 10000, '충성 고객을 위한 10% 할인 쿠폰');
INSERT INTO DISCOUNT VALUES ('FAMILY25', 2500, '가족 단위 예약 시 25% 할인');
INSERT INTO DISCOUNT VALUES ('CHRISTMAS', 8000, '크리스마스 특별 할인 이벤트');
INSERT INTO DISCOUNT VALUES ('BIRTHDAY', 4000, '생일을 맞이한 고객에게 특별 할인');
INSERT INTO DISCOUNT VALUES ('AUTUMN24', 6000, '2024년 가을철 한정 특별 할인');
INSERT INTO DISCOUNT VALUES ('REPEAT5', 5000, '5번째 방문 시 추가 할인 제공');
INSERT INTO DISCOUNT VALUES ('NEWYEAR', 10000, '새해 맞이 특별 할인 이벤트');
INSERT INTO DISCOUNT VALUES ('HALLOWEEN', 3000, '할로윈 기념 할인 이벤트');
INSERT INTO DISCOUNT VALUES ('STUDENT', 1500, '학생들을 위한 10% 할인 쿠폰');
INSERT INTO DISCOUNT VALUES ('EASTER', 6000, '부활절 특별 할인 이벤트');
INSERT INTO DISCOUNT VALUES ('MIDYEAR', 4500, '년중 특별 할인 이벤트');
INSERT INTO DISCOUNT VALUES ('FRIENDS20', 2000, '친구와 함께 방문 시 20% 할인');
INSERT INTO DISCOUNT VALUES ('B_FRIDAY', 9000, '블랙 프라이데이 특별 할인');
INSERT INTO DISCOUNT VALUES ('WINTER24', 8000, '2024년 겨울철 한정 특별 할인');
INSERT INTO DISCOUNT VALUES ('COMEBACK', 7000, '재방문 고객을 위한 추가 할인');
INSERT INTO DISCOUNT VALUES ('SPECIAL50', 5000, '특별 기념일 50% 할인 이벤트');
INSERT INTO DISCOUNT VALUES ('TEACHER10', 2000, '교사들을 위한 10% 할인 쿠폰');
INSERT INTO DISCOUNT VALUES ('ANNIVER', 10000, '매년 기념일마다 제공되는 할인');
INSERT INTO DISCOUNT VALUES ('SP_BREAK', 3000, '봄 방학 기간 동안 제공되는 할인');
INSERT INTO DISCOUNT VALUES ('VIP20', 8000, 'VIP 고객을 위한 20% 할인 쿠폰');
INSERT INTO DISCOUNT VALUES ('RETIRE', 7000, '은퇴 기념 특별 할인 이벤트');
INSERT INTO DISCOUNT VALUES ('STAY', 6000, '근처 여행객을 위한 특별 할인');
INSERT INTO DISCOUNT VALUES ('MILITARY', 3000, '군인 및 보훈대상자를 위한 할인');
INSERT INTO DISCOUNT VALUES ('RETURN', 5000, '복귀 고객을 위한 추가 할인');
INSERT INTO DISCOUNT VALUES ('COUPLE20', 2500, '커플 이용 고객을 위한 20% 할인');
INSERT INTO DISCOUNT VALUES ('SUMMER25', 7000, '2025년 여름 특별 할인');

SELECT * FROM DISCOUNT;

-- CHARGE 데이터 입력 및 조회
-- 방문 데이터 1
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 100000001;
-- 방문 데이터 2
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 100000002;
-- 방문 데이터3
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 100000003;
-- 방문 데이터 4
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay - D.discount_money,
    visit_num,
    'FIRST'
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
JOIN DISCOUNT D ON D.discount_code = 'FIRST'
WHERE visit_num = 100000004;
-- 방문 데이터 5
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 100000005;
-- 방문 데이터 6
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 100000006;
-- 방문 데이터7
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 100000007;
-- 방문 데이터8
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay - D.discount_money,
    visit_num,
    'SUMMER'
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
JOIN DISCOUNT D ON D.discount_code = 'SUMMER'
WHERE visit_num = 100000008;
-- 방문 데이터9
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 100000009;
-- 방문 데이터 10
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 100000010;
-- 방문 데이터11
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 100000011;
-- 방문 데이터12
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay - D.discount_money,
    visit_num,
    'WEEKEND20'
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
JOIN DISCOUNT D ON D.discount_code = 'WEEKEND20'
WHERE visit_num = 100000012;
-- 방문 데이터13
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 100000013;
-- 방문 데이터14
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 1000000014;
-- 방문 데이터15
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 100000015;
-- 방문 데이터16
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay - D.discount_money,
    visit_num,
    'LOYALTY10'
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
JOIN DISCOUNT D ON D.discount_code = 'LOYALTY10'
WHERE visit_num = 100000016;
-- 방문 데이터17
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay - D.discount_money,
    visit_num,
    'STAY'
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
JOIN DISCOUNT D ON D.discount_code = 'STAY'
WHERE visit_num = 100000017;
-- 방문 데이터18
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 1000000018;
-- 방문 데이터19
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 100000019;
-- 방문 데이터20
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 1000000020;
-- 방문 데이터21
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 100000021;
-- 방문 데이터 22
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay - D.discount_money,
    visit_num,
    'EASTER'
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
JOIN DISCOUNT D ON D.discount_code = 'EASTER'
WHERE visit_num = 100000022;
-- 방문 데이터 23
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay - D.discount_money,
    visit_num,
    'ANNIVER'
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
JOIN DISCOUNT D ON D.discount_code = 'ANNIVER'
WHERE visit_num = 100000023;
-- 방문 데이터 24
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay - D.discount_money,
    visit_num,
    'B_FRIDAY'
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
JOIN DISCOUNT D ON D.discount_code = 'B_FRIDAY'
WHERE visit_num = 100000024;
-- 방문 데이터 25
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay - D.discount_money,
    visit_num,
    'B_FRIDAY'
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
JOIN DISCOUNT D ON D.discount_code = 'B_FRIDAY'
WHERE visit_num = 100000025;
-- 방문 데이터26
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 1000000026;
-- 방문 데이터27
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 100000027;
-- 방문 데이터28
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay - D.discount_money,
    visit_num,
    'COMEBACK'
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
JOIN DISCOUNT D ON D.discount_code = 'COMEBACK'
WHERE visit_num = 100000028;
-- 방문 데이터29
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay - D.discount_money,
    visit_num,
    'MILITARY'
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
JOIN DISCOUNT D ON D.discount_code = 'MILITARY'
WHERE visit_num = 100000029;
-- 방문 데이터30
INSERT INTO CHARGE (charge_sum, visit_num, discount_code)
SELECT 
    (HOUR(visit_finish) - HOUR(visit_start) + 1) * P.parking_pay,
    visit_num,
    NULL
FROM VISIT V
JOIN PARKING P ON V.parking_id = P.parking_id
WHERE visit_num = 1000000030;

SELECT * FROM CHARGE
ORDER BY visit_num ASC;

-- PAY 데이터 입력 및 조회
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(1, '2024-07-01 11:30:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000001),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000001),
    100000001);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(2, '2024-07-02 17:00:00', '카드', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000002),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000002),
    100000002);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(3, '2024-07-03 15:30:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000003),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000003),
    100000003);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(4, '2024-07-04 11:45:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000004),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000004),
    100000004);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(5, '2024-07-05 11:00:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000005),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000005),
    100000005);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(6, '2024-07-06 16:20:00', '카드', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000006),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000006),
    100000006);

INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(7, '2024-07-07 13:15:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000007),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000007),
    100000007);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(8, '2024-07-08 18:00:00', '카드', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000008),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000008),
    100000008);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(9, '2024-07-09 10:45:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000009),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000009),
    100000009);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(10, '2024-07-10 12:30:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000010),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000010),
    100000010);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(11, '2024-07-11 10:30:00', '카드', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000011),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000011),
    100000011);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(12, '2024-07-12 16:30:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000012),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000012),
    100000012);

INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(13, '2024-07-13 19:15:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000013),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000013),
    100000013);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(15, '2024-07-14 14:30:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000015),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000015),
    100000015);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(16, '2024-07-16 12:30:00', '카드', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000016),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000016),
    100000016);

INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(17, '2024-07-17 10:15:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000017),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000017),
    100000017);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(19, '2024-07-19 16:50:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000019),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000019),
    100000019);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(21, '2024-07-21 14:15:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000021),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000021),
    100000021);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(22, '2024-07-22 13:50:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000022),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000022),
    100000022);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(23, '2024-07-23 09:35:00', '카드', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000023),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000023),
    100000023);

INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(24, '2024-07-25 12:50:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000024),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000024),
    100000024);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(25, '2024-07-25 16:30:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000025),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000025),
    100000025);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(27, '2024-07-27 15:10:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000027),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000027),
    100000027);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(28, '2024-08-08 21:30:00', '카드', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000028),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000028),
    100000028);
    
INSERT INTO PAY (pay_num, pay_date, pay_type, pay_money, user_id, visit_num)
VALUES
(29, '2024-08-15 16:55:00', '현금', 
    (SELECT C.charge_sum FROM CHARGE C WHERE C.visit_num = 100000029),
     (SELECT V.user_id FROM VISIT V WHERE V.visit_num=100000029),
    100000029);

SELECT * FROM PAY
ORDER BY visit_num ASC;


-- 예제문1 서울시 강남구에 살고있는 사용자의 이름과 주소를 나타내라.
SELECT user_name, user_address
FROM USERS
WHERE user_address LIKE "서울시 강남구%";

-- 예제문2 트럭을 가지고 있는 사용자의 이름과 전화번호를 나타내라.
SELECT user_name, user_phone
FROM USERS U JOIN CAR C ON U.user_id=C.user_id
WHERE car_type LIKE "트럭";

-- 예제문3 서울을 제외한 지역에 주차장을 관리하고 있는 관리자의 이름을 나타내라.
SELECT manager_name
FROM MANAGER 
WHERE manager_address NOT LIKE '서울%';

-- 예제문4 시간당 요금이 15000~20000원 사이인 주차장id와 주차장 주소를 나타내라.
SELECT parking_id, parking_location
FROM PARKING
WHERE parking_pay Between 15000 AND 20000;

-- 예제문5 예약 데이터에서 예약을 실패한 예약 번호와 날짜를 나타내라.
SELECT reservation_num, reservation_date
FROM RESERVATION
WHERE reservation_status='n';

-- 예제문6 PARKING001 주차장에 방문한 사용자의 이름과 날짜와 시간, 자리번호를 나타내라 
SELECT U.user_name, V.visit_date, V.visit_start, V.visit_finish, V.spot_num
FROM VISIT V JOIN USERS U ON V.user_id = U.user_id
WHERE V.parking_id = 'PARKING001';

-- 예제문7 할인 금액이 5000원 이상되는 할인코드와, 할인금액, 설명을 나타내라
SELECT discount_code, discount_money, discount_d
FROM DISCOUNT
WHERE discount_money>=5000;









