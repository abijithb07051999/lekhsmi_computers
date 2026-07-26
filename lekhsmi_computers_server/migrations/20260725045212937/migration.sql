BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "brand" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "status" boolean NOT NULL DEFAULT true
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "category" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "status" boolean NOT NULL DEFAULT true
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "expense" (
    "id" bigserial PRIMARY KEY,
    "date" timestamp without time zone NOT NULL,
    "reason" text NOT NULL,
    "amount" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "income" (
    "id" bigserial PRIMARY KEY,
    "date" timestamp without time zone NOT NULL,
    "reason" text NOT NULL,
    "amount" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "orderhistory" (
    "id" bigserial PRIMARY KEY,
    "order" json NOT NULL,
    "status" text NOT NULL,
    "amount" bigint NOT NULL DEFAULT 0
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "orders" (
    "id" bigserial PRIMARY KEY,
    "orderId" text NOT NULL,
    "customerName" text NOT NULL,
    "contact1" bigint NOT NULL,
    "contact2" bigint,
    "email" text,
    "address" text NOT NULL,
    "date" timestamp without time zone NOT NULL,
    "complaints" json NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "product" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "categoryId" bigint NOT NULL,
    "brandId" bigint NOT NULL,
    "quality" text NOT NULL,
    "quantity" bigint NOT NULL,
    "buyPrice" bigint NOT NULL,
    "sellPrice" bigint NOT NULL,
    "status" boolean NOT NULL DEFAULT true
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "supplier" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "address" text NOT NULL,
    "contact1" bigint NOT NULL,
    "contact2" bigint NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "product"
    ADD CONSTRAINT "product_fk_0"
    FOREIGN KEY("categoryId")
    REFERENCES "category"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "product"
    ADD CONSTRAINT "product_fk_1"
    FOREIGN KEY("brandId")
    REFERENCES "brand"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR lekhsmi_computers
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('lekhsmi_computers', '20260725045212937', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260725045212937', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
