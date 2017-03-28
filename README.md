<h1> Fava Web Application: Social Food Delivery Service </h1>
<h2> Creators: Samantha Siegel, Philip Moss, John Martin, and Ivoryanna Brown </h2>

<p> Our project, Fava, is a social, peer-to-peer, food delivery service aimed at engaging Duke students in social and monetary exchanges on campus. This is a work in progress! </p>

<p> Developed using Ruby on Rails, HTML, CSS, and JavaScript </p>

<h2> Cloning </h2>
git clone https://github.com/samanthasiegel/Fava.git

<h2> Building </h2>
<p> Install the dependencies, as specified in the Gemfile: </p>
<p> bundle install </p>
<p> Import the CSV files to initialize database tables: </p>
<p> rake import:restaurants </p>
<p>rake import:food_items</p>

<h2> Running </h2>
<p>
rails server 
<p>

<h2> Troubleshooting </h2>
If receiving errors about unimplemented migrations:
<p>rails db:migrate <p>
or
<p> bundle exec rails db:migrate </p>