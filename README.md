# README

## model

1. User
  - id :integer
  - name :varchar
  - email :varchar
  - password_digest :varchar
2. Task
  - id :integer
  - user_id :integer
  - title :varchar
  - content :text
  - priority :varchar
  - deadline :datetime
  - status :varchar
3. Label
  - id :integer
  - task_id :integer
  - content :text
