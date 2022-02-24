# テーブル管理
*users*
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| title              | string     | null: false                    |
| email              | string     | null: false,unique: true       |
| password_digest    | string     | null: false                    |

*tasks*
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| use_id             | references | null: false, foreign_key: true |
| name               | string     | null: false                    |
| detail             | text       | null: false                    |
| start_day          | date       | null: false                    |
| end_day            | date       | null: false                    |
| status             | string     | null: false                    |

*labels*
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user_id            | references | null: false, foreign_key: true |
| task_id            | references | null: false, foreign_key: true |

#  Herokuデプロイ
*バージョン*  
ruby 2.6.5  
rails 5.2.5  
heroku-18  

*手順*  
1.herokuに新しいアプリ作成(heroku create)  
2.herokuのstackを18に下げる(heroku stack:set heroku-18)  
3.herokuへデプロイ(git push heroku step02:master)  
4.マイグレーションする(heroku run rails db:migrate)  