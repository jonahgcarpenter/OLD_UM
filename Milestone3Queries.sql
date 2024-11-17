INSERT INTO location (id, name, address, city, state, zip) VALUES 
  (1, 'Vaught-Hemingway Stadium', '335 Stadium Dr', 'Oxford', 'MS', '38655'),
  (2, 'Swayze Field', '100 Bailey Ln', 'Oxford', 'MS', '38655'),
  (3, 'Tad Smith Coliseum', '1101-1199 All-American Dr', 'University', 'MS', '38677'),
  (4, 'Manning Center', '1848 Manning Way', 'University', 'MS', '38677'),
  (5, 'Gillom Center', '2301 S Lamar Blvd', 'Oxford', 'MS', '38655');


INSERT INTO event (id, name, date, location_id, channel, sport) VALUES 
  (1, 'Ole Miss vs Alabama', '2022-09-17', 1, 'CBS', 'Football'),
  (2, 'Ole Miss vs LSU', '2022-10-01', 1, 'ABC', 'Football'),
  (3, 'Ole Miss vs Memphis', '2022-12-04', 1, 'ESPN', 'Football'),
  (4, 'Ole Miss vs Mississippi State', '2023-02-21', 1, NULL, 'Baseball'),
  (5, 'Ole Miss vs Arkansas', '2023-03-04', 2, NULL, 'Baseball'),
  (6, 'Ole Miss vs Southern Miss', '2023-03-14', 2, NULL, 'Baseball'),
  (7, 'Ole Miss vs Auburn', '2023-01-11', 3, NULL, 'Basketball'),
  (8, 'Ole Miss vs Tennessee', '2023-01-18', 3, NULL, 'Basketball'),
  (9, 'Ole Miss vs Vanderbilt', '2023-01-25', 3, NULL, 'Basketball'),
  (10, 'Ole Miss vs Mississippi State', '2023-02-21', 3, NULL, 'Basketball'),
  (11, 'Ole Miss vs Texas A&M', '2023-03-04', 3, NULL, 'Basketball'),
  (12, 'Ole Miss vs Kentucky', '2023-03-08', 3, NULL, 'Basketball'),
  (13, 'Ole Miss vs LSU', '2023-03-11', 3, NULL, 'Basketball'),
  (14, 'Ole Miss vs Alabama', '2023-03-15', 3, NULL, 'Basketball'),
  (15, 'Ole Miss vs Auburn', '2023-03-18', 3, NULL, 'Basketball');


INSERT INTO predict (event_id, win_probability, spread) VALUES
(1, 70, '+7'),
(2, 65, '-3'),
(3, 80, '+10'),
(4, 45, '+14'),
(5, 75, '-5'),
(6, 50, '+3'),
(7, 55, '-7'),
(8, 90, '+21'),
(9, 60, '+10'),
(10, 70, '-3'),
(11, 85, '+14'),
(12, 50, '-5'),
(13, 70, '-7'),
(14, 95, '+21'),
(15, 80, '-10');

INSERT INTO eventstats (event_id, score, period, opponent) VALUES
(1, '21-17', 4, 'Alabama'),
(2, '28-21', 4, 'LSU'),
(3, '35-10', 4, 'Arkansas'),
(4, '42-35', 4, 'Auburn'),
(5, '24-21', 4, 'Texas A&M'),
(6, '28-31', 4, 'Mississippi State'),
(7, '10-17', 4, 'Ole Miss'),
(8, '56-7', 4, 'Vanderbilt'),
(9, '28-24', 4, 'Georgia'),
(10, '21-14', 4, 'Kentucky'),
(11, '35-14', 4, 'South Carolina'),
(12, '28-31', 4, 'Mississippi State'),
(13, '21-24', 4, 'LSU'),
(14, '63-3', 4, 'New Mexico State'),
(15, '35-31', 4, 'Memphis');

INSERT INTO player (event_id, first_name, last_name, major, year, height, weight, sport, position, jersey_number) VALUES
(1, 'John', 'Doe', 'Business', 'Junior', 70, 175, 'Football', 'Quarterback', 10),
(1, 'Jane', 'Doe', 'Nursing', 'Sophomore', 68, 160, 'Football', 'Wide Receiver', 23),
(1, 'Mark', 'Johnson', 'Engineering', 'Freshman', 72, 180, 'Football', 'Linebacker', 42),
(2, 'Sarah', 'Smith', 'Psychology', 'Senior', 66, 155, 'Football', 'Cornerback', 12),
(2, 'David', 'Lee', 'English', 'Junior', 74, 190, 'Football', 'Defensive End', 56),
(2, 'Michael', 'Garcia', 'Political Science', 'Sophomore', 70, 180, 'Football', 'Safety', 30),
(3, 'Emily', 'Brown', 'Biology', 'Freshman', 67, 150, 'Football', 'Running Back', 33),
(3, 'Joshua', 'Miller', 'Communications', 'Senior', 73, 200, 'Football', 'Offensive Tackle', 77),
(3, 'Katherine', 'Gonzalez', 'International Studies', 'Junior', 70, 170, 'Football', 'Defensive Tackle', 99);