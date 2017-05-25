/*
 Navicat PostgreSQL Data Transfer

 Source Server         : local
 Source Server Version : 90602
 Source Host           : localhost
 Source Database       : postgres
 Source Schema         : public

 Target Server Version : 90602
 File Encoding         : utf-8

 Date: 05/22/2017 13:29:10 PM
*/

-- ----------------------------
--  Sequence structure for department_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."department_id_seq";
CREATE SEQUENCE "public"."department_id_seq" INCREMENT 1 START 100 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;
ALTER TABLE "public"."department_id_seq" OWNER TO "postgres";

-- ----------------------------
--  Sequence structure for form_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."form_id_seq";
CREATE SEQUENCE "public"."form_id_seq" INCREMENT 1 START 100 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;
ALTER TABLE "public"."form_id_seq" OWNER TO "postgres";

-- ----------------------------
--  Sequence structure for job_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."job_id_seq";
CREATE SEQUENCE "public"."job_id_seq" INCREMENT 1 START 100 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;
ALTER TABLE "public"."job_id_seq" OWNER TO "postgres";

-- ----------------------------
--  Sequence structure for question_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."question_id_seq";
CREATE SEQUENCE "public"."question_id_seq" INCREMENT 1 START 100 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;
ALTER TABLE "public"."question_id_seq" OWNER TO "postgres";

-- ----------------------------
--  Sequence structure for question_option_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."question_option_id_seq";
CREATE SEQUENCE "public"."question_option_id_seq" INCREMENT 1 START 100 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;
ALTER TABLE "public"."question_option_id_seq" OWNER TO "postgres";

-- ----------------------------
--  Sequence structure for question_type_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."question_type_id_seq";
CREATE SEQUENCE "public"."question_type_id_seq" INCREMENT 1 START 100 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;
ALTER TABLE "public"."question_type_id_seq" OWNER TO "postgres";

-- ----------------------------
--  Sequence structure for role_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."role_id_seq";
CREATE SEQUENCE "public"."role_id_seq" INCREMENT 1 START 100 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;
ALTER TABLE "public"."role_id_seq" OWNER TO "postgres";

-- ----------------------------
--  Sequence structure for status_type_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."status_type_id_seq";
CREATE SEQUENCE "public"."status_type_id_seq" INCREMENT 1 START 100 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;
ALTER TABLE "public"."status_type_id_seq" OWNER TO "postgres";

-- ----------------------------
--  Sequence structure for task_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."task_id_seq";
CREATE SEQUENCE "public"."task_id_seq" INCREMENT 1 START 100 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;
ALTER TABLE "public"."task_id_seq" OWNER TO "postgres";

-- ----------------------------
--  Sequence structure for task_type_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."task_type_id_seq";
CREATE SEQUENCE "public"."task_type_id_seq" INCREMENT 1 START 100 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;
ALTER TABLE "public"."task_type_id_seq" OWNER TO "postgres";

-- ----------------------------
--  Sequence structure for user_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."user_id_seq";
CREATE SEQUENCE "public"."user_id_seq" INCREMENT 1 START 100 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;
ALTER TABLE "public"."user_id_seq" OWNER TO "postgres";

-- ----------------------------
--  Sequence structure for user_id_seq1
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."user_id_seq1";
CREATE SEQUENCE "public"."user_id_seq1" INCREMENT 1 START 100 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;
ALTER TABLE "public"."user_id_seq1" OWNER TO "postgres";

-- ----------------------------
--  Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS "public"."question";
CREATE TABLE "public"."question" (
	"id" int4 NOT NULL DEFAULT nextval('question_id_seq'::regclass),
	"question" varchar(255) COLLATE "default",
	"answer" varchar(255) COLLATE "default",
	"form_id" int4,
	"question_type_id" int4
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."question" OWNER TO "postgres";

-- ----------------------------
--  Records of question
-- ----------------------------
BEGIN;
INSERT INTO "public"."question" VALUES ('1', 'what was purchased', 'office supplies', '1', '1');
INSERT INTO "public"."question" VALUES ('2', 'what was amount', '95.23', '1', '6');
INSERT INTO "public"."question" VALUES ('3', 'upload recipent', 'reciept.png', '1', '3');
INSERT INTO "public"."question" VALUES ('4', 'select a department', 'finance', '1', '4');
COMMIT;

-- ----------------------------
--  Table structure for form
-- ----------------------------
DROP TABLE IF EXISTS "public"."form";
CREATE TABLE "public"."form" (
	"id" int4 NOT NULL DEFAULT nextval('form_id_seq'::regclass),
	"form_name" varchar(255) COLLATE "default",
	"form_description" varchar(255) COLLATE "default",
	"task_id" int4
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."form" OWNER TO "postgres";

-- ----------------------------
--  Records of form
-- ----------------------------
BEGIN;
INSERT INTO "public"."form" VALUES ('1', 'reciept', 'submit reciept', '3');
COMMIT;
-- ----------------------------
--  Table structure for job
-- ----------------------------
DROP TABLE IF EXISTS "public"."job";
CREATE TABLE "public"."job" (
	"id" int4 NOT NULL DEFAULT nextval('job_id_seq'::regclass),
	"job_name" varchar(255) COLLATE "default",
	"job_description" varchar(255) COLLATE "default",
	"manager_id" int4,
	"worker_id" int4,
	"status_id" int4,
	"start_date" date,
	"end_date" date,
	"completed_date" date
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."job" OWNER TO "postgres";

-- ----------------------------
--  Records of job
-- ----------------------------
BEGIN;
INSERT INTO "public"."job" VALUES ('1', 'Buy Office Supplies', 'Go to Staples on Coit to buy office supplies', '4', '5', '1', '2017-05-22', '2017-05-22', null);
COMMIT;

-- ----------------------------
--  Table structure for department
-- ----------------------------

-- ----------------------------
--  Table structure for status_type
-- ----------------------------
DROP TABLE IF EXISTS "public"."status_type";
CREATE TABLE "public"."status_type" (
	"id" int4 NOT NULL DEFAULT nextval('status_type_id_seq'::regclass),
	"type" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."status_type" OWNER TO "postgres";

-- ----------------------------
--  Records of status_type
-- ----------------------------
BEGIN;
INSERT INTO "public"."status_type" VALUES ('1', 'Scheduled');
INSERT INTO "public"."status_type" VALUES ('2', 'Work in Progress');
INSERT INTO "public"."status_type" VALUES ('3', 'Completed');
INSERT INTO "public"."status_type" VALUES ('4', 'Cancelled');
INSERT INTO "public"."status_type" VALUES ('5', 'Delayed');
COMMIT;



-- ----------------------------
--  Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS "public"."role";
CREATE TABLE "public"."role" (
	"id" int4 NOT NULL DEFAULT nextval('role_id_seq'::regclass),
	"role_name" varchar(255) COLLATE "default",
	"role_description" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."role" OWNER TO "postgres";

-- ----------------------------
--  Records of role
-- ----------------------------
BEGIN;
INSERT INTO "public"."role" VALUES ('2', 'Manager', 'Manager Role');
INSERT INTO "public"."role" VALUES ('3', 'Worker', 'Worker Role');
INSERT INTO "public"."role" VALUES ('1', 'Owner', 'Owner Role');
COMMIT;

-- ----------------------------
--  Table structure for question_type
-- ----------------------------
DROP TABLE IF EXISTS "public"."question_type";
CREATE TABLE "public"."question_type" (
	"id" int4 NOT NULL DEFAULT nextval('question_type_id_seq'::regclass),
	"type" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."question_type" OWNER TO "postgres";

-- ----------------------------
--  Records of question_type
-- ----------------------------
BEGIN;
INSERT INTO "public"."question_type" VALUES ('1', 'text');
INSERT INTO "public"."question_type" VALUES ('2', 'image');
INSERT INTO "public"."question_type" VALUES ('3', 'signature');
INSERT INTO "public"."question_type" VALUES ('4', 'select');
INSERT INTO "public"."question_type" VALUES ('5', 'multiselect');
INSERT INTO "public"."question_type" VALUES ('6', 'number');
INSERT INTO "public"."question_type" VALUES ('7', 'boolean');
COMMIT;

-- ----------------------------
--  Table structure for task_type
-- ----------------------------
DROP TABLE IF EXISTS "public"."task_type";
CREATE TABLE "public"."task_type" (
	"id" int4 NOT NULL DEFAULT nextval('task_type_id_seq'::regclass),
	"type" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."task_type" OWNER TO "postgres";

-- ----------------------------
--  Records of task_type
-- ----------------------------
BEGIN;
INSERT INTO "public"."task_type" VALUES ('1', 'form');
INSERT INTO "public"."task_type" VALUES ('2', 'location');
INSERT INTO "public"."task_type" VALUES ('3', 'activity');
COMMIT;

-- ----------------------------
--  Table structure for question_option
-- ----------------------------
DROP TABLE IF EXISTS "public"."question_option";
CREATE TABLE "public"."question_option" (
	"id" int4 NOT NULL DEFAULT nextval('question_option_id_seq'::regclass),
	"question_id" int4,
	"option_name" varchar(255) COLLATE "default",
	"option_value" varchar(255) COLLATE "default",
	"is_value_default" bool
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."question_option" OWNER TO "postgres";

-- ----------------------------
--  Records of question_option
-- ----------------------------
BEGIN;
INSERT INTO "public"."question_option" VALUES ('4', '4', 'Finance', 'finance', 't');
INSERT INTO "public"."question_option" VALUES ('5', '4', 'Accounting', 'accounting', 'f');
INSERT INTO "public"."question_option" VALUES ('6', '4', 'Marketing', 'marketing', 'f');
COMMIT;

-- ----------------------------
--  Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS "public"."user";
CREATE TABLE "public"."user" (
	"id" int4 NOT NULL DEFAULT nextval('user_id_seq1'::regclass),
	"user_name" varchar(255) COLLATE "default",
	"first_name" varchar(255) COLLATE "default",
	"last_name" varchar(255) COLLATE "default",
	"role_id" int4,
	"department_id" int4,
	"supervisor_id" int4
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."user" OWNER TO "postgres";

-- ----------------------------
--  Records of user
-- ----------------------------
BEGIN;
INSERT INTO "public"."user" VALUES ('3', 'jpgdallas', 'John', 'Grumble', '1', '1', null);
INSERT INTO "public"."user" VALUES ('4', 'mgr1', 'Sally', 'Managerton', '2', '1', '3');
INSERT INTO "public"."user" VALUES ('5', 'worker1', 'Bill', 'Workerton', '3', '1', '4');
COMMIT;

-- ----------------------------
--  Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS "public"."task";
CREATE TABLE "public"."task" (
	"id" int4 NOT NULL DEFAULT nextval('task_id_seq'::regclass),
	"task_name" varchar(255) COLLATE "default",
	"task_description" varchar(255) COLLATE "default",
	"job_id" int4,
	"task_type_id" int4,
	"status_id" int4,
	"step" int4,
	"start_date" date,
	"end_date" date,
	"completed_date" date
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."task" OWNER TO "postgres";

-- ----------------------------
--  Records of task
-- ----------------------------
BEGIN;
INSERT INTO "public"."task" VALUES ('1', 'Drive to Staples', '500 Coit Rd Plano, TX', '1', '2', '1', '1', null, null, null);
INSERT INTO "public"."task" VALUES ('2', 'Buy Supplies', 'Printer paper and pens', '1', '3', '1', '2', null, null, null);
INSERT INTO "public"."task" VALUES ('3', 'Submit reciept', 'Home office', '1', '1', '1', '3', null, null, null);
INSERT INTO "public"."task" VALUES ('4', 'Return to office', '5001 Tennyson Dr, Plano, TX', '1', '2', '1', '4', null, null, null);
COMMIT;

DROP TABLE IF EXISTS "public"."department";
CREATE TABLE "public"."department" (
	"id" int4 NOT NULL DEFAULT nextval('department_id_seq'::regclass),
	"department_name" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."department" OWNER TO "postgres";

-- ----------------------------
--  Records of department
-- ----------------------------
BEGIN;
INSERT INTO "public"."department" VALUES ('1', 'Office');
COMMIT;

-- ----------------------------
--  Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."department_id_seq" RESTART 2 OWNED BY "department"."id";
ALTER SEQUENCE "public"."form_id_seq" RESTART 2 OWNED BY "form"."id";
ALTER SEQUENCE "public"."job_id_seq" RESTART 3 OWNED BY "job"."id";
ALTER SEQUENCE "public"."question_id_seq" RESTART 2 OWNED BY "question"."id";
ALTER SEQUENCE "public"."question_option_id_seq" RESTART 2 OWNED BY "question_option"."id";
ALTER SEQUENCE "public"."question_type_id_seq" RESTART 2 OWNED BY "question_type"."id";
ALTER SEQUENCE "public"."role_id_seq" RESTART 2 OWNED BY "role"."id";
ALTER SEQUENCE "public"."status_type_id_seq" RESTART 2 OWNED BY "status_type"."id";
ALTER SEQUENCE "public"."task_id_seq" RESTART 2 OWNED BY "task"."id";
ALTER SEQUENCE "public"."task_type_id_seq" RESTART 2 OWNED BY "task_type"."id";
ALTER SEQUENCE "public"."user_id_seq" RESTART 2;
ALTER SEQUENCE "public"."user_id_seq1" RESTART 2 OWNED BY "user"."id";
-- ----------------------------
--  Primary key structure for table question
-- ----------------------------
ALTER TABLE "public"."question" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table job
-- ----------------------------
ALTER TABLE "public"."job" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table department
-- ----------------------------
ALTER TABLE "public"."department" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table status_type
-- ----------------------------
ALTER TABLE "public"."status_type" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table form
-- ----------------------------
ALTER TABLE "public"."form" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table role
-- ----------------------------
ALTER TABLE "public"."role" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table question_type
-- ----------------------------
ALTER TABLE "public"."question_type" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table task_type
-- ----------------------------
ALTER TABLE "public"."task_type" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table question_option
-- ----------------------------
ALTER TABLE "public"."question_option" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table user
-- ----------------------------
ALTER TABLE "public"."user" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table task
-- ----------------------------
ALTER TABLE "public"."task" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table question
-- ----------------------------
ALTER TABLE "public"."question" ADD CONSTRAINT "fk_questionform" FOREIGN KEY ("form_id") REFERENCES "public"."form" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."question" ADD CONSTRAINT "fk_questiontype" FOREIGN KEY ("question_type_id") REFERENCES "public"."question_type" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table job
-- ----------------------------
ALTER TABLE "public"."job" ADD CONSTRAINT "fk_job" FOREIGN KEY ("manager_id") REFERENCES "public"."user" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table form
-- ----------------------------
ALTER TABLE "public"."form" ADD CONSTRAINT "fk_form" FOREIGN KEY ("task_id") REFERENCES "public"."task" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table question_option
-- ----------------------------
ALTER TABLE "public"."question_option" ADD CONSTRAINT "fk_question_option" FOREIGN KEY ("question_id") REFERENCES "public"."question" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table user
-- ----------------------------
ALTER TABLE "public"."user" ADD CONSTRAINT "fk_usersuper" FOREIGN KEY ("supervisor_id") REFERENCES "public"."user" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."user" ADD CONSTRAINT "fk_userdepart" FOREIGN KEY ("department_id") REFERENCES "public"."department" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."user" ADD CONSTRAINT "fk_userrole" FOREIGN KEY ("role_id") REFERENCES "public"."role" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table task
-- ----------------------------
ALTER TABLE "public"."task" ADD CONSTRAINT "fk_taskjob" FOREIGN KEY ("job_id") REFERENCES "public"."job" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."task" ADD CONSTRAINT "fk_taskstatus" FOREIGN KEY ("status_id") REFERENCES "public"."status_type" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."task" ADD CONSTRAINT "fk_tasktasktype" FOREIGN KEY ("task_type_id") REFERENCES "public"."task_type" ("id") ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE;
