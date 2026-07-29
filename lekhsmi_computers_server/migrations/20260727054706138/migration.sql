BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "supplier" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "supplier" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "address" text NOT NULL,
    "contact1" bigint NOT NULL,
    "contact2" bigint NOT NULL,
    "status" boolean NOT NULL
);


--
-- MIGRATION VERSION FOR lekhsmi_computers
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('lekhsmi_computers', '20260727054706138', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260727054706138', "timestamp" = now();

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
