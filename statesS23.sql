DROP TABLE IF EXISTS statesS23;

CREATE TABLE statesS23(
Num int NOT NULL,
Name varchar(40),
Abbr char(2),
Capital varchar(40),
Est date,
Flower varchar(50),
PRIMARY KEY(Num)
);

INSERT INTO statesS23 VALUES(22, 'Alabama', 'AL', 'Montgomery', '1819-12-14', 'Camelia');
INSERT INTO statesS23 VALUES(49, 'Alaska', 'AK', 'Juneau', '1959-01-03', 'Forget-me-not');
INSERT INTO statesS23 VALUES(48, 'Arizona', 'AZ', 'Phoenix', '1912-02-14', 'Saguaro cactus blossom');
INSERT INTO statesS23 VALUES(25, 'Arkansas', 'AR', 'Little Rock', '1836-06-15', 'Apple blossom');
INSERT INTO statesS23 VALUES(31, 'California', 'CA', 'Sacramento', '1850-09-09', 'California poppy');
INSERT INTO statesS23 VALUES(38, 'Colorado', 'CO', 'Denver', '1876-08-01', 'Rocky Mountain columbine');
INSERT INTO statesS23 VALUES(5, 'Connecticut', 'CT', 'Hartford', '1788-01-09', 'Mountain laurel');
INSERT INTO statesS23 VALUES(1, 'Delaware', 'DE', 'Dover', '1787-12-07', 'Peach blossom');
INSERT INTO statesS23 VALUES(27, 'Florida', 'FL', 'Tallahassee', '1845-03-03', 'Orange blossom');
INSERT INTO statesS23 VALUES(4, 'Georgia', 'GA', 'Atlanta', '1788-01-02', 'Cherokee rose');
INSERT INTO statesS23 VALUES(50, 'Hawaii', 'HI', 'Honolulu', '1959-08-21', 'Hawaiian hibiscus');
INSERT INTO statesS23 VALUES(43, 'Idaho', 'ID', 'Boise', '1890-07-03', 'Mock orange syringa');
INSERT INTO statesS23 VALUES(21, 'Illinois', 'IL', 'Springfield', '1818-12-03', 'Violet');
INSERT INTO statesS23 VALUES(19, 'Indiana', 'IN', 'Indianapolis', '1816-12-11', 'Peony');
INSERT INTO statesS23 VALUES(29, 'Iowa', 'IA', 'Des Moines', '1846-12-28', 'Wild rose');
INSERT INTO statesS23 VALUES(34, 'Kansas', 'KS', 'Topeka', '1861-01-29', 'Sunflower');
INSERT INTO statesS23 VALUES(15, 'Kentucky', 'KY', 'Frankfort', '1792-06-01', 'Goldenrod');
INSERT INTO statesS23 VALUES(18, 'Louisiana', 'LA', 'Baton Rouge', '1812-04-30', 'Magnolia');
INSERT INTO statesS23 VALUES(23, 'Maine', 'ME', 'Augusta', '1820-03-15', 'White pine cone');
INSERT INTO statesS23 VALUES(7, 'Maryland', 'MD', 'Annapolis', '1788-04-28', 'Black-eyed susan');
INSERT INTO statesS23 VALUES(6, 'Massachusetts', 'MA', 'Boston', '1788-02-06', 'Mayflower');
INSERT INTO statesS23 VALUES(26, 'Michigan', 'MI', 'Lansing', '1837-01-26', 'Apple blossom');
INSERT INTO statesS23 VALUES(32, 'Minnesota', 'MN', 'St. Paul', '1858-05-11', 'Pink and white lady\'s slipper');
INSERT INTO statesS23 VALUES(20, 'Mississippi', 'MS', 'Jackson', '1817-12-10', 'Magnolia');
INSERT INTO statesS23 VALUES(24, 'Missouri', 'MO', 'Jefferson City', '1821-08-10', 'Hawthorn');
INSERT INTO statesS23 VALUES(41, 'Montana', 'MT', 'Helena', '1889-11-08', 'Bitterroot');
INSERT INTO statesS23 VALUES(37, 'Nebraska', 'NE', 'Lincoln', '1867-03-01', 'Goldenrod');
INSERT INTO statesS23 VALUES(36, 'Nevada', 'NV', 'Carson City', '1864-10-31', 'Sagebrush');
INSERT INTO statesS23 VALUES(9, 'New Hampshire', 'NH', 'Concord', '1788-06-21', 'Purple lilac');
INSERT INTO statesS23 VALUES(3, 'New Jersey', 'NJ', 'Trenton', '1787-12-18', 'Violet');
INSERT INTO statesS23 VALUES(47, 'New Mexico', 'NM', 'Santa Fe', '1912-01-06', 'Yucca flower');
INSERT INTO statesS23 VALUES(11, 'New York', 'NY', 'Albany', '1788-07-26', 'Rose');
INSERT INTO statesS23 VALUES(12, 'North Carolina', 'NC', 'Raleigh', '1789-11-21', 'Dogwood');
INSERT INTO statesS23 VALUES(39, 'North Dakota', 'ND', 'Bismarck', '1889-11-02', 'Wild prairie rose');
INSERT INTO statesS23 VALUES(17, 'Ohio', 'OH', 'Columbus', '1803-03-01', 'Scarlet carnation');
INSERT INTO statesS23 VALUES(46, 'Oklahoma', 'OK', 'Oklahoma City', '1907-11-16', 'Oklahoma rose');
INSERT INTO statesS23 VALUES(33, 'Oregon', 'OR', 'Salem', '1859-02-14', 'Oregon grape');
INSERT INTO statesS23 VALUES(2, 'Pennsylvania', 'PA', 'Harrisburg', '1787-12-12', 'Mountain laurel');
INSERT INTO statesS23 VALUES(13, 'Rhode Island', 'RI', 'Providence', '1790-05-29', 'Violet');
INSERT INTO statesS23 VALUES(8, 'South Carolina', 'SC', 'Columbia', '1788-05-23', 'Yellow jessamine');
INSERT INTO statesS23 VALUES(40, 'South Dakota', 'SD', 'Pierre', '1889-11-02', 'Pasque flower');
INSERT INTO statesS23 VALUES(16, 'Tennessee', 'TN', 'Nashville', '1796-06-01', 'Iris');
INSERT INTO statesS23 VALUES(28, 'Texas', 'TX', 'Austin', '1845-12-29', 'Bluebonnet');
INSERT INTO statesS23 VALUES(45, 'Utah', 'UT', 'Salt Lake City', '1896-01-04', 'Sego lily');
INSERT INTO statesS23 VALUES(14, 'Vermont', 'VT', 'Montpelier', '1791-03-04', 'Red clover');
INSERT INTO statesS23 VALUES(10, 'Virginia', 'VA', 'Richmond', '1788-06-25', 'Dogwood');
INSERT INTO statesS23 VALUES(42, 'Washington', 'WA', 'Olympia', '1889-11-11', 'Rhododendron');
INSERT INTO statesS23 VALUES(35, 'West Virginia', 'WV', 'Charleston', '1863-06-20', 'Rhododendron' );
INSERT INTO statesS23 VALUES(30, 'Wisconsin', 'WI', 'Madison', '1848-05-29', 'Violet');
INSERT INTO statesS23 VALUES(44, 'Wyoming', 'WY', 'Cheyenne', '1890-07-10', 'Indian paintbrush');
