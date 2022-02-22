# usersテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| email              | string     | null: false,unique: true       |
| password_digest    | string     | null: false                    |

# tasksテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| use_id             | references | null: false, foreign_key: true |
| name               | string     | null: false                    |
| detail             | text       | null: false                    |
| start_day          | date       | null: false                    |
| end_day            | date       | null: false                    |
| status             | string     | null: false                    |

# labelテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user_id            | references | null: false, foreign_key: true |
| task_id            | references | null: false, foreign_key: true |

