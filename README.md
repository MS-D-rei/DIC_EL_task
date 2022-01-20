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

## Heroku deploy

1. `% create heroku`
2. `% heroku buildpacks:set heroku/ruby`
3. `% heroku buildpacks:add --index 1 heroku/nodejs`
4. `% add bundle lock --add-platform x86_64-linux`
5. `% git add .`
6. `% git commit -m '<commit comment>'`
7. `% git push heroku step2:main`