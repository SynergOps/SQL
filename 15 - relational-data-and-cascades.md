# Relational Integrity, Cascades, and Multi-Level Joins

Learn how relational databases enforce referential integrity using foreign keys, how cascading actions (`ON DELETE CASCADE`) handle cleanup across connected tables, and how to query nested relationships across multiple joined tables.

## Setup

Create a new database (or schema) and import `datasets/photo-share/photo-share.sql`:

```bash
# PostgreSQL
createdb photodb
psql photodb < datasets/photo-share/photo-share.sql

# MySQL / MariaDB (note: adjust syntax for AUTO_INCREMENT if using raw MySQL client)
mysql -u root -p -e "CREATE DATABASE photodb;"
mysql -u root -p photodb < datasets/photo-share/photo-share.sql
```

The database models a photo-sharing platform with three interconnected tables:
- `users`: Registered users (`id`, `username`)
- `photos`: Uploaded photos with owner reference (`id`, `url`, `user_id` $\rightarrow$ `users.id`)
- `comments`: Comments linked to both the commenter and the target photo (`id`, `contents`, `user_id` $\rightarrow$ `users.id`, `photo_id` $\rightarrow$ `photos.id`)

---

## 1. Understanding Referential Integrity & Foreign Keys

Foreign keys establish parent-child relationships and protect against orphaned records:

```sql
-- View all photos along with their owner's username
SELECT 
    p.id AS photo_id,
    p.url,
    u.username AS author
FROM photos p
INNER JOIN users u ON p.user_id = u.id;
```

Try inserting a photo for a non-existent user (`user_id = 999`):

```sql
INSERT INTO photos (url, user_id)
VALUES ('https://invalid.url.com/img.jpg', 999);
```

> [!NOTE]
> The database aborts the operation with a **Foreign Key Violation**. An RDBMS guarantees that a child row cannot reference a parent that does not exist.

---

## 2. Multi-Level Joins (Three-Table Relationships)

When data spans parent, child, and grandchild tables, we chain `JOIN` clauses.

### Complete Comment Thread with Author and Photo Owner

```sql
SELECT 
    c.id AS comment_id,
    c.contents,
    commenter.username AS commented_by,
    photo_author.username AS photo_owner,
    p.url AS photo_url
FROM comments c
INNER JOIN users commenter ON c.user_id = commenter.id
INNER JOIN photos p ON c.photo_id = p.id
INNER JOIN users photo_author ON p.user_id = photo_author.id
ORDER BY c.id
LIMIT 10;
```

Notice we join the `users` table **twice** using distinct aliases (`commenter` and `photo_author`) to distinguish between the user who wrote the comment and the user who published the photo.

---

## 3. Detecting Self-Interactions (Users Commenting on Their Own Photos)

Compare foreign keys across relationships to discover self-activity:

```sql
SELECT 
    u.username,
    p.url AS photo_url,
    c.contents AS comment
FROM comments c
INNER JOIN photos p ON c.photo_id = p.id
INNER JOIN users u ON c.user_id = u.id
WHERE c.user_id = p.user_id;
```

---

## 4. Correlated Subqueries & Nested Aggregation

### Find each photo with its total comment count (without GROUP BY)

Using a correlated scalar subquery in the `SELECT` list:

```sql
SELECT 
    p.id AS photo_id,
    p.url,
    (SELECT COUNT(*) FROM comments c WHERE c.photo_id = p.id) AS total_comments
FROM photos p
ORDER BY total_comments DESC;
```

### Find users who haven't uploaded any photos yet

Using `NOT EXISTS` ensures optimal indexing and performance:

```sql
SELECT u.id, u.username
FROM users u
WHERE NOT EXISTS (
    SELECT 1 
    FROM photos p 
    WHERE p.user_id = u.id
);
```

### Find photos that have more comments than the platform average

```sql
WITH photo_comment_counts AS (
    SELECT photo_id, COUNT(*) AS count
    FROM comments
    GROUP BY photo_id
)
SELECT 
    p.id,
    p.url,
    pcc.count AS comments_received
FROM photo_comment_counts pcc
INNER JOIN photos p ON pcc.photo_id = p.id
WHERE pcc.count > (SELECT AVG(count) FROM photo_comment_counts);
```

---

## 5. Demonstrating Cascading Deletes (`ON DELETE CASCADE`)

When `ON DELETE CASCADE` is set on a foreign key constraint:
* Deleting a `photo` automatically deletes all comments linked to that `photo`.
* Deleting a `user` automatically deletes all `photos` belonging to that user **AND** cascades down to delete all comments on those photos, as well as all comments written by that user.

### Step 1: Check existing counts before deletion

```sql
SELECT 
    (SELECT COUNT(*) FROM users) AS user_count,
    (SELECT COUNT(*) FROM photos) AS photo_count,
    (SELECT COUNT(*) FROM comments) AS comment_count;
```

### Step 2: Check activity for user 1 ('Marcus_Webb')

```sql
-- Photos owned by Marcus
SELECT COUNT(*) FROM photos WHERE user_id = 1;

-- Comments written by Marcus
SELECT COUNT(*) FROM comments WHERE user_id = 1;
```

### Step 3: Delete user 1

```sql
DELETE FROM users WHERE id = 1;
```

### Step 4: Verify cascade results

```sql
SELECT 
    (SELECT COUNT(*) FROM users) AS user_count,
    (SELECT COUNT(*) FROM photos) AS photo_count,
    (SELECT COUNT(*) FROM comments) AS comment_count;
```

> [!IMPORTANT]
> Without `ON DELETE CASCADE`, the RDBMS would have refused the `DELETE FROM users` command with a foreign key constraint error, requiring you to manually delete every dependent comment and photo first.

---

## Practice Exercises

1. Write a query to find the user whose photos received the highest total number of comments across the platform.
2. Using a `LEFT JOIN`, list all users and the URL of their most recent photo (or `NULL` if they have none).
3. Find all users who commented on photos owned by 'Sophia.Ramirez'.
4. Write a query that finds pairs of users who have commented on each other's photos.
