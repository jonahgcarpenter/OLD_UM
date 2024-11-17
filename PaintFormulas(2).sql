DROP TABLE IF EXISTS Paint1NF;

CREATE TABLE Paint1NF (
COLORCODE CHAR(3),
COLORNAME VARCHAR(20),
COLORANT VARCHAR(20),
COLORANTCODE VARCHAR(3),
CANSIZE CHAR(1),
VOLUME VARCHAR(2),
QTY  VARCHAR(3)
);

INSERT INTO Paint1NF VALUES('001', 'TangierIsland', 'BlackOxide', 'B', 'g', '48', '18');
INSERT INTO Paint1NF VALUES('001', 'TangierIsland', 'RedOxide', 'F', 'g', '48', '10');
INSERT INTO Paint1NF VALUES('001', 'TangierIsland', 'OrganicYellow', 'AXX', 'g', '1', '1');
INSERT INTO Paint1NF VALUES('001', 'TangierIsland', 'OrganicYellow', 'AXX', 'g', '48', '6');

INSERT INTO Paint1NF VALUES('001', 'TangierIsland', 'BlackOxide', 'B', 'q', '48', '4');
INSERT INTO Paint1NF VALUES('001', 'TangierIsland', 'BlackOxide', 'B', 'q', '96', '1');
INSERT INTO Paint1NF VALUES('001', 'TangierIsland', 'RedOxide', 'F', 'q', '48', '2');
INSERT INTO Paint1NF VALUES('001', 'TangierIsland', 'RedOxide', 'F', 'q', '96', '1');
INSERT INTO Paint1NF VALUES('001', 'TangierIsland', 'OrganicYellow', 'AXX', 'q', '48', '10');

INSERT INTO Paint1NF VALUES('002', 'BarnRed', 'BlackOxide', 'B', 'g', '48', '20');
INSERT INTO Paint1NF VALUES('002', 'BarnRed', 'RedOxide', 'F', 'g', '48', '40');
INSERT INTO Paint1NF VALUES('002', 'BarnRed', 'Magenta', 'V', 'g', '48', '12');
INSERT INTO Paint1NF VALUES('002', 'BarnRed', 'OrganicYellow', 'AXX', 'g', '48', '20');
INSERT INTO Paint1NF VALUES('002', 'BarnRed', 'TitaniumWhite', 'KX', 'g', '48', '16');


INSERT INTO Paint1NF VALUES('003', 'NavajoRed', 'BrownOxide', 'I', 'g', '1', '2');
INSERT INTO Paint1NF VALUES('003', 'NavajoRed', 'BrownOxide', 'I', 'g', '48', '41');
INSERT INTO Paint1NF VALUES('003', 'NavajoRed', 'BrownOxide', 'I', 'g', '96', '1');
INSERT INTO Paint1NF VALUES('003', 'NavajoRed', 'OrganicRed', 'R', 'g', '1', '5');
INSERT INTO Paint1NF VALUES('003', 'NavajoRed', 'OrganicRed', 'R', 'g', '48', '47');
INSERT INTO Paint1NF VALUES('003', 'NavajoRed', 'OrganicRed', 'R', 'g', '96', '1');
INSERT INTO Paint1NF VALUES('003', 'NavajoRed', 'MediumYellow', 'T', 'g', '1', '2');
INSERT INTO Paint1NF VALUES('003', 'NavajoRed', 'MediumYellow', 'T', 'g', '48', '8');
INSERT INTO Paint1NF VALUES('003', 'NavajoRed', 'MediumYellow', 'T', 'g', '96', '1');
INSERT INTO Paint1NF VALUES('003', 'NavajoRed', 'TitaniumWhite', 'KX', 'g', '48', '47');

INSERT INTO Paint1NF VALUES('004', 'DustyMauve', 'BlackOxide', 'B', 'g', '48', '19');
INSERT INTO Paint1NF VALUES('004', 'DustyMauve', 'BlackOxide', 'B', 'g', '96', '1');
INSERT INTO Paint1NF VALUES('004', 'DustyMauve', 'MediumYellow', 'T', 'g', '48', '30');
INSERT INTO Paint1NF VALUES('004', 'DustyMauve', 'Magenta', 'V', 'g', '1', '1');
INSERT INTO Paint1NF VALUES('004', 'DustyMauve', 'Magenta', 'V', 'g', '48', '8');


INSERT INTO Paint1NF VALUES('005', 'Silver', 'RawUmber', 'L', 'g', '48', '36');
INSERT INTO Paint1NF VALUES('005', 'Silver', 'RawUmber', 'L', 'g', '96', '1');
INSERT INTO Paint1NF VALUES('005', 'Silver', 'PhaloBlue', 'E', 'g', '48', '5');
INSERT INTO Paint1NF VALUES('005', 'Silver', 'PhaloBlue', 'E', 'g', '96', '1');
INSERT INTO Paint1NF VALUES('005', 'Silver', 'Magenta', 'V', 'g', '48', '5');
INSERT INTO Paint1NF VALUES('005', 'Silver', 'Magenta', 'V', 'g', '96', '1');

INSERT INTO Paint1NF VALUES('006', 'JPastel', 'RawUmber', 'L', 'g', '48', '16');
INSERT INTO Paint1NF VALUES('006', 'JPastel', 'RawUmber', 'L', 'g', '96', '1');
INSERT INTO Paint1NF VALUES('006', 'JPastel', 'MediumYellow', 'T', 'g', '48', '34');
INSERT INTO Paint1NF VALUES('006', 'JPastel', 'Magenta', 'V', 'g', '1', '1');
INSERT INTO Paint1NF VALUES('006', 'JPastel', 'Magenta', 'V', 'g', '48', '38');

SELECT * FROM Paint1NF WHERE COLORCODE='004';
