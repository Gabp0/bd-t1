\copy region FROM '/home/gab/projetos/database/TPC-H_V3.0.1/dbgen/tbl/region.tbl' DELIMITER '|' CSV;
\copy nation FROM '/home/gab/projetos/database/TPC-H_V3.0.1/dbgen/tbl/nation.tbl' DELIMITER '|' CSV;
\copy customer FROM '/home/gab/projetos/database/TPC-H_V3.0.1/dbgen/tbl/customer.tbl' DELIMITER '|' CSV;
\copy orders FROM '/home/gab/projetos/database/TPC-H_V3.0.1/dbgen/tbl/orders.tbl' DELIMITER '|' CSV;
\copy part FROM '/home/gab/projetos/database/TPC-H_V3.0.1/dbgen/tbl/part.tbl' DELIMITER '|' CSV;
\copy supplier FROM '/home/gab/projetos/database/TPC-H_V3.0.1/dbgen/tbl/supplier.tbl' DELIMITER '|' CSV;
\copy lineitem FROM '/home/gab/projetos/database/TPC-H_V3.0.1/dbgen/tbl/lineitem.tbl' DELIMITER '|' CSV;
\copy partsupp FROM '/home/gab/projetos/database/TPC-H_V3.0.1/dbgen/tbl/partsupp.tbl' DELIMITER '|' CSV;

