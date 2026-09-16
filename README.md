# MicroUniversity databases — MIS 425

This repository contains the MicroUniversity sample dataset: eight related tables and 281 rows for practicing SQL and building course applications.

## Start here: Supabase

**Homework 2 requires CSV imports.** Follow the assignment for that workflow; the SQL script below demonstrates a second import method and does not replace the CSV requirement. Use separate schemas when comparing both methods.

You can create your own **free Supabase account using your Franklin email address** and begin without waiting for an invitation. The instructor plans to send a separate invitation to a reference database setup; that invitation is for viewing the instructor's example.

1. Sign up at [Supabase](https://supabase.com/) using your Franklin email. Choose the Free plan and create a project for your coursework. Keep the database password private.
2. Open [`supabase.sql`](supabase.sql) in this repository and copy the complete file. On GitHub, use **Raw** to view just the SQL text.
3. Open your project's **SQL Editor**, create a new query, paste the complete script, and run it. The script creates the `microuniversity` schema if needed. That schema must not already contain these eight tables.
4. Open **Table Editor** and select the `microuniversity` schema. PostgreSQL stores these unquoted table and column names in lowercase: for example, `student` and `stu_num`.
5. Run [`verify.sql`](verify.sql) in SQL Editor. Every `actual_rows` value should match `expected_rows` in the result.

The setup includes both the table definitions and the sample rows. Use one import method per set of tables. If you already imported the CSV files into `microuniversity`, do not run this complete setup on top of them. To practice both methods, use a separate schema for the second import and consistently update the SQL schema references. Run the whole script together, with no partial text selection. It uses a transaction to keep table creation and inserts together. If a run fails, issue `ROLLBACK;` before retrying; do not assume an error means a previous run created no tables. If a table already exists, the script stops without replacing it. Do not delete your existing work just to repeat setup.

### Organize tables with schemas

A schema is a named group of tables inside the project's database. Use `microuniversity` for the MicroUniversity dataset, then another schema such as `travel_dashboard` for your final project. In **Table Editor**, open the schema dropdown and choose **Create a new schema**, enter the name, and save. You can also use SQL Editor:

```sql
CREATE SCHEMA IF NOT EXISTS microuniversity;
```

Select the intended schema before importing CSV files. Selecting a schema in Table Editor does not change where a SQL script creates its tables. This repository's `supabase.sql` explicitly targets `microuniversity` throughout, including foreign keys and row-level security statements. To adapt it to another schema, consistently replace every `microuniversity` reference in both `supabase.sql` and `verify.sql`.

If you imported an earlier version into `public` or `sql_demo`, those tables stay there. This script neither moves nor deletes them. Check the Table Editor schema dropdown before assuming tables are missing. An “already exists” error means the setup is being run against an existing object; use SELECT queries to inspect the data rather than rerunning CREATE TABLE.

Unquoted SQL names become lowercase. A CSV-created table named `EMPLOYEE` requires `microuniversity."EMPLOYEE"`; the SQL-created table is `microuniversity.employee`.

### Ask for help

If you need the instructor to access your coursework database, invite **tyler.whitney@franklin.edu** through your Supabase organization's **Team** settings. Use the **Developer** role for database assistance, then let the instructor know you sent the invitation.

On the Free plan, membership applies to the organization, including its other projects. Keep coursework in an organization containing only projects you intend to share. Project-only access and a Read-Only role require Team or Enterprise plans; you do not need to upgrade for the course setup. Invitations currently expire after 24 hours, so an expired invitation may need to be resent. Do not use the Authentication section's application-user invitation feature for instructor collaboration, and do not email passwords or API secrets.

[Supabase collaboration and access documentation](https://supabase.com/docs/guides/platform/access-control)

### Appsmith connections and data access

Use [Franklin University’s hosted Appsmith environment](https://franklinuniv.dp.appsmith.com/applications), which is licensed for educational use. Sign in with your Franklin account through the university sign-in flow. Use this environment for coursework; you do not need to start a separate Appsmith trial or purchase a plan. The instructor will demonstrate its use in the live session.

If you see a trial-expiration warning, first check that you are using the Franklin URL above. If the warning or an access error persists there, send the instructor the URL, workspace name, and exact message.

The Supabase script enables row-level security on all eight tables and does not grant public Data API access. You can inspect and query the data in SQL Editor. An Appsmith PostgreSQL datasource uses a database connection; its access depends on the database role used. Use the connection details from your project's **Connect** dialog and the course demonstration. Keep connection credentials in the datasource settings, not in page widgets, browser JavaScript, or GitHub. If you instead use the Supabase REST API, appropriate grants and row-level policies are a separate setup step; do not disable security just to make a request succeed.

In Appsmith SQL queries, use schema-qualified names such as `microuniversity.course`. Keep the database name from the Connect dialog in the datasource configuration; a schema name is not a database name. The same datasource can query other schemas when its database role has the required permissions.

[Supabase row-level security documentation](https://supabase.com/docs/guides/database/postgres/row-level-security)

## Download the CSV files

No GitHub invitation or account is needed to download this public repository. Choose **Code → Download ZIP** on the repository's main page, then extract it. Alternatively, open an individual `.csv` file and use **Download raw file**.

The CSV files are the original interchange format, with uppercase headers and month/day/year date strings. Blank fields represent missing values. If importing them manually, create the schema first, map the headers to its columns, and check dates and null handling. Import in this order to satisfy foreign keys:

1. `employee.csv`
2. `school.csv`
3. `department.csv`
4. `course.csv`
5. `class.csv`
6. `student.csv`
7. `enroll.csv`
8. `professor.csv`

For the SQL import demonstration, `supabase.sql` creates and loads `microuniversity` using unambiguous ISO dates (`YYYY-MM-DD`). For Homework 2, complete the assigned CSV imports in your own schema, such as `microuniversity`.

## Files and database engines

| File | Purpose |
| --- | --- |
| `supabase.sql` | PostgreSQL/Supabase tables and all sample rows in `microuniversity`; SQL import demonstration |
| `database.sql` | SQLite schema and sample rows; not a Supabase script |
| `verify.sql` | Read-only PostgreSQL row-count check for `microuniversity` |
| `*.csv` | Individual sample tables for inspection or manual import |

Both setup scripts are for initial creation. Neither deletes existing tables. The SQLite script enables foreign-key enforcement for its connection; SQLite applications must enable it on each subsequent connection too.

## Tables and relationships

| Table | Rows | Meaning |
| --- | ---: | --- |
| `employee` | 37 | Employees, including teaching staff |
| `school` | 2 | Schools and their employee leads |
| `department` | 11 | Departments, school membership, and employee leads |
| `course` | 28 | Course catalog |
| `class` | 44 | Scheduled course sections and instructors |
| `student` | 38 | Students, departments, and employee advisors |
| `enroll` | 99 | Student enrollment in classes |
| `professor` | 22 | Additional information about teaching employees |

`enroll` has a composite primary key (`class_code`, `stu_num`): a student can enroll only once in a given class. Other tables each have a single primary key. Foreign keys connect schools to employees, departments to schools/employees, courses to departments, classes to courses/employees, students to departments/employees, enrollments to classes/students, and professors to departments/employees.

The PostgreSQL version also checks nonnegative student hours, GPA from 0 to 4 (or NULL), positive course/enrollment credits, and a transfer flag of 0 or 1. Existing identifiers and teaching relationships are preserved.

## Try a query

```sql
SELECT s.stu_num, s.stu_fname, s.stu_lname,
       c.crs_code, c.crs_description, e.enroll_grade
FROM microuniversity.student AS s
JOIN microuniversity.enroll AS e ON e.stu_num = s.stu_num
JOIN microuniversity.class AS cl ON cl.class_code = e.class_code
JOIN microuniversity.course AS c ON c.crs_code = cl.crs_code
ORDER BY s.stu_num, cl.class_code;
```

The original data includes historical dates, missing GPAs/phone values, and `-` as an unassigned grade. These have been preserved for consistency with course exercises. A NULL GPA is not zero. The data is a teaching sample, not a current Franklin student roster; do not replace it with real student records.
