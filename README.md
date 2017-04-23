<h1> Fava Web Application: Social Food Delivery Service </h1>
<h2> Creators: Samantha Siegel, Philip Moss, John Martin, and Ivoryanna Brown </h2>

<p> Our project, Fava, is a social, peer-to-peer, food delivery service aimed at engaging Duke students in social and monetary exchanges on campus. This is a work in progress! </p>

<p> Developed using Ruby on Rails, HTML, CSS, and JavaScript </p>

<h2> Cloning </h2>
git clone https://github.com/samanthasiegel/Fava.git

<h2> Building </h2>
<p><b>NOTE:</b> You must have RUby on Rails installed on your system to continue. If you do not have Ruby on Rails installed, <a href="http://railsapps.github.io/installrubyonrails-ubuntu.html">here</a> is an installation guide.</p>

<p> Install the dependencies, as specified in the Gemfile: </p>
<p> bundle install </p>
<p> Import the CSV files to initialize database tables: </p>
<p> rake import:restaurants </p>
<p> rake import:food_items</p>
<p> rake import:sizes</p>
<p> rake import:sides</p>
<p> rake import:categories</p>


<h2> Running </h2>

<p>
rails server 
<p>

<h2> Troubleshooting </h2>
If receiving errors about unimplemented migrations of if importing the CSV files is failing, try:
<p style="font-family:'Lucida Console', monospace">rails db:migrate </p>
or
<p style="font-family:'Lucida Console', monospace"> bundle exec rails db:migrate </p>

If "bundle install" returns "ERROR: Failed to build gem native extension" on an attempt to install the 'pg' (PostgresSQL) gem, try: 

<p style="font-family:'Lucida Console', monospace">sudo apt-get install libpq-dev </p>
and then
<p style="font-family:'Lucida Console', monospace">gem install pg -v '<b>0.20.0</b>'</p>
NOTE: Update the version in the command as needed.

