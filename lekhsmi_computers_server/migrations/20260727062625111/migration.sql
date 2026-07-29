BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "purchase" (
    "id" bigserial PRIMARY KEY,
    "invoiceNo" text NOT NULL,
    "date" timestamp without time zone NOT NULL,
    "supplierId" bigint NOT NULL,
    "totalAmount" bigint NOT NULL,
    "paidAmount" bigint NOT NULL,
    "dueAmount" bigint NOT NULL,
    "paymentStatus" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "purchase_item" (
    "id" bigserial PRIMARY KEY,
    "purchaseId" bigint NOT NULL,
    "productId" bigint NOT NULL,
    "quantity" bigint NOT NULL,
    "unitPrice" bigint NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "purchase"
    ADD CONSTRAINT "purchase_fk_0"
    FOREIGN KEY("supplierId")
    REFERENCES "supplier"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "purchase_item"
    ADD CONSTRAINT "purchase_item_fk_0"
    FOREIGN KEY("purchaseId")
    REFERENCES "purchase"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "purchase_item"
    ADD CONSTRAINT "purchase_item_fk_1"
    FOREIGN KEY("productId")
    REFERENCES "product"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR lekhsmi_computers
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('lekhsmi_computers', '20260727062625111', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260727062625111', "timestamp" = now();

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
