#Schedular The Scheduler
Ruby on Rails Scheduler

Introduction

This is a solution for scheduling/managing “Cron Jobs” by a web portal so that, not only an expert, an intermediate but also a Novice can schedule a cron Job at his system. 
	From this Scheduler you can schedule only One time job but also Recurring jobs which can happen every minute, hourly, weekly, hourly, monthly and yearly. You can also select sub jobs to be rescheduled at some other if required.
	This scheduler is developed on Ruby on Rails Platform for Web Development, MySQL as database and DelayedJob as Scheduler Wrapper. Web UI of this application is built with Bootswatch ( extended themed version of Bootstrap framework ).

Database Scheme

	# == Schema Information
	#
	# Table name: events
	#
	#  id             :integer          not null, primary key
	#  name           :string(255)
	#  occurrence     :string(255)
	#  start_at       :datetime
	#  job_name       :string(255)
	#  job_arguments  :json
	#  created_at     :datetime         not null
	#  updated_at     :datetime         not null
	#  priority       :integer          default("10")
	#  job_id         :integer
	#  frequency      :string(255)      default("")
	#  execution_time :text(65535)
	#
	# Table name: event_results
	#
	#  id         :integer          not null, primary key
	#  event_id   :integer
	#  job_id     :string(255)
	#  queue      :string(255)
	#  attempts   :integer
	#  last_error :text(65535)
	#  priority   :integer
	#  locked_by  :text(65535)
	#  run_at     :datetime
	#  failed_at  :datetime
	#  created_at :datetime         not null
	#  updated_at :datetime         not null
	#  status     :string(255)      default("Pending")


Pr-requisites

MySQL.
Ruby – 2.2.5
Rails – 5.0.2

Recommendation - Installation of Ruby on Rails is preferred with RVM ( for more information visit : https://rvm.io/ ). For full installation of Ruby on Rails visit : http://askrubyexpert.com/articles/installing-ruby-on-rails-in-ubuntu

Application Setup

After successful installation, change your directory to application’s root directory and run “bundle install”.
Once all gems are installed, open database.yml file in side config folder in your favorite editor and replace the user name and password of the database and save the file.
To create and setup database, run command “rake db:migrate”, this will create all necessary tables with database.
Finally run “rails  s”, this will start your rails server on your machine at port number 3000. Now you can visit http://localhost:3000 in your browser for browsing portal.
To start Scheduler Daemon, please open another tab on your command prompt or terminal and run “rake jobs:work” to see scheduled jobs running.

Thanks



 


