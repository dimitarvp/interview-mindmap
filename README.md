# Inteview assignment: Dimi for MindMeister

### Description

This repository implements the interview assignment given to me by MindMeister.

### Local PostgreSQL databases that will be affected

By running the scripts described below, you should expect the following databases to be dropped, created and modified:
- `interview_mindmap_pure_sql`
- `interview_mindmap_dev`
- `interview_mindmap_test`

### How to validate this homework

- Task 1 is an SQL script and is implemented inside `scripts/payments.sql`.
- Task 2 is an SQL script and is implemented inside `scripts/topics.sql`. Note that this SQL script ignores users and doesn't include them.
- Task 3 is this Elixir repository itself. This task includes users (unlike Task 2). Read on for instructions on how to validate this task.

The actual implementation of Task 3 is in `lib/mm/topics.ex`, functions `roots_by_user_id/1` and `search/3`.

The tests that confirm the implementation is correct are in `test/mm_test.exs`:
- The test marked as `"create user and topic"` is a basic sanity check: namely that one user and one topic can be inserted in the DB.
- The test marked as `"list all root topics of a user"` inserts users and topics and makes sure that fetching the root topics of one of them is yielding the correct values.
- The test marked as `"searching"` demonstrates the search capability: given a user ID, potentially a topic that should be the root of the search (if empty, the very root of the mind map is assumed) and a name fragment, all topics from levels 0, 1 and 2 are searched and returned.

### How to validate Task 1

Run the following commands:

```sh
createdb interview_mindmap_pure_sql
psql -U postgres interview_mindmap_pure_sql -f scripts/payments.sql
dropdb interview_mindmap_pure_sql
```

The expected output is documented inside the script.

### How to validate Task 2

Run the following commands:

```sh
createdb interview_mindmap_pure_sql
psql -U postgres interview_mindmap_pure_sql -f scripts/topics.sql
dropdb interview_mindmap_pure_sql
```

The expected output is documented inside the script.

### How to validate Task 3

Run `mix test`. If all tests pass, the task is a success. Feel free to inspect the sources specified above to make sure.
