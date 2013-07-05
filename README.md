Publishing App
=========

A simple Articles Publishing system, created as a solution to an ROR developer position recruitment process question.

Platform: Rails 4.0.0
Database: Mysql

Devise used for authentication purpose and CanCan gem for User role management. For Design and UI, used the bootstrap-sass gem.

Devise 3.0.0.rc

Problem: Develop a simple publishing rails application with authentication using Devise, which has the following features.
* Different User Roles: Admin, Editor, Reporter & Guest
* Reporter can register via the application
* Only Admin can create Editor
* Editor can publish any article
* Guest can read any article
* Reporters can draft an Article (but not publish)
* Reporter can read/edit any of his articles/drafts.

Published Application can be found at Heroku: http://aqueous-gorge-3568.herokuapp.com
Test Administrator Account: 
Username: Administrator
Password: 12345678

