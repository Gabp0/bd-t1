-- Create REGION table
CREATE TABLE REGION (
    R_REGIONKEY SERIAL PRIMARY KEY,
    R_NAME CHAR(25) NOT NULL,
    R_COMMENT VARCHAR(152) NOT NULL
);

-- Create NATION table with foreign key to REGION
CREATE TABLE NATION (
    N_NATIONKEY SERIAL PRIMARY KEY,
    N_NAME CHAR(25) NOT NULL,
    N_REGIONKEY INT REFERENCES REGION(R_REGIONKEY),
    N_COMMENT VARCHAR(152) NOT NULL
);

-- Create CUSTOMER table with foreign key to NATION
CREATE TABLE CUSTOMER (
    C_CUSTKEY SERIAL PRIMARY KEY,
    C_NAME VARCHAR(25) NOT NULL,
    C_ADDRESS VARCHAR(40) NOT NULL,
    C_NATIONKEY INT REFERENCES NATION(N_NATIONKEY),
    C_PHONE CHAR(15) NOT NULL,
    C_ACCTBAL DECIMAL,
    C_MKTSEGMENT CHAR(10) NOT NULL,
    C_COMMENT VARCHAR(117) NOT NULL
);

-- Create PART table
CREATE TABLE PART (
    P_PARTKEY SERIAL PRIMARY KEY,
    P_NAME VARCHAR(55) NOT NULL,
    P_MFGR CHAR(25) NOT NULL,
    P_BRAND CHAR(10) NOT NULL,
    P_TYPE VARCHAR(25) NOT NULL,
    P_SIZE INT NOT NULL,
    P_CONTAINER CHAR(10) NOT NULL,
    P_RETAILPRICE DECIMAL NOT NULL,
    P_COMMENT VARCHAR(23) NOT NULL
);

-- Create SUPPLIER table with foreign key to NATION
CREATE TABLE SUPPLIER (
    S_SUPPKEY SERIAL PRIMARY KEY,
    S_NAME CHAR(25) NOT NULL,
    S_ADDRESS VARCHAR(40) NOT NULL,
    S_NATIONKEY INT REFERENCES NATION(N_NATIONKEY),
    S_PHONE CHAR(15) NOT NULL,
    S_ACCTBAL DECIMAL,
    S_COMMENT VARCHAR(101) NOT NULL
);

-- Create PARTSUPP table with foreign keys to PART and SUPPLIER
CREATE TABLE PARTSUPP (
    PS_PARTKEY INT REFERENCES PART(P_PARTKEY),
    PS_SUPPKEY INT REFERENCES SUPPLIER(S_SUPPKEY),
    PS_AVAILQTY INT NOT NULL,
    PS_SUPPLYCOST DECIMAL NOT NULL,
    PS_COMMENT VARCHAR(199) NOT NULL,
    PRIMARY KEY (PS_PARTKEY, PS_SUPPKEY)
);

-- Create ORDERS table with foreign key to CUSTOMER
CREATE TABLE ORDERS (
    O_ORDERKEY SERIAL PRIMARY KEY,
    O_CUSTKEY INT REFERENCES CUSTOMER(C_CUSTKEY),
    O_ORDERSTATUS CHAR(1) NOT NULL,
    O_TOTALPRICE DECIMAL,
    O_ORDERDATE DATE,
    O_ORDERPRIORITY CHAR(15) NOT NULL,
    O_CLERK CHAR(15) NOT NULL,
    O_SHIPPRIORITY INT NOT NULL,
    O_COMMENT VARCHAR(79) NOT NULL
);

-- Create LINEITEM table with foreign keys to ORDERS, PART, and SUPPLIER
CREATE TABLE LINEITEM (
    L_ORDERKEY INT REFERENCES ORDERS(O_ORDERKEY),
    L_PARTKEY INT REFERENCES PART(P_PARTKEY),
    L_SUPPKEY INT REFERENCES SUPPLIER(S_SUPPKEY),
    L_LINENUMBER INT NOT NULL,
    L_QUANTITY DECIMAL NOT NULL,
    L_EXTENDEDPRICE DECIMAL NOT NULL,
    L_DISCOUNT DECIMAL NOT NULL,
    L_TAX DECIMAL NOT NULL,
    L_RETURNFLAG CHAR(1) NOT NULL,
    L_LINESTATUS CHAR(1) NOT NULL,
    L_SHIPDATE DATE NOT NULL,
    L_COMMITDATE DATE NOT NULL,
    L_RECEIPTDATE DATE NOT NULL,
    L_SHIPINSTRUCT CHAR(25) NOT NULL,
    L_SHIPMODE CHAR(10) NOT NULL,
    L_COMMENT VARCHAR(44) NOT NULL
);
