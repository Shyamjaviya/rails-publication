## Requirements
- Ruby 3.2
- Rails 8.x (or the version you used)
- Sqlite Database
- Js Assets

## Setup

**Clone the repository**
git clone https://github.com/Shyamjaviya/rails-publication.git
cd rails-publication

**Change branch**
## If you are in main branch then follow below steps.
git pull origin master
git checkout master

**Install dependencies**
bundle install

**Setup database**
rails db:create
rails db:migrate

**Start rails server**
## The project will initially start on the port 3000
rails server