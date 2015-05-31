# all the imports
import os,binascii
from flask import Flask, request, session, g, redirect, url_for, abort, \
		render_template, flash, Blueprint, stream_with_context, Response
from flaskext.mysql import MySQL
from flask_mail import Mail,Message
from config import config, ADMINS, MAIL_SERVER, MAIL_PORT, MAIL_USERNAME, MAIL_PASSWORD
from werkzeug.utils import secure_filename
from flask import send_from_directory
import datetime, json
from pprint import pprint
from collections import Counter
from time import sleep
import re, datetime
import urllib2, urllib
import requests, chartkick
from flask_oauthlib.client import OAuth
import hashlib, random
 
import logging
from logging.handlers import SMTPHandler
credentials = None

mysql = MySQL()
# create our little application :)

app = Flask(__name__)

for key in config:
	app.config[key] = config[key]

mail = Mail(app)
# Mail
mail.init_app(app)

if MAIL_USERNAME or MAIL_PASSWORD:
	credentials = (MAIL_USERNAME, MAIL_PASSWORD)
	mail_handler = SMTPHandler((MAIL_SERVER, MAIL_PORT), 'no-reply@' + MAIL_SERVER, ADMINS, 'resetpass', credentials)
	mail_handler.setLevel(logging.ERROR)
	app.logger.addHandler(mail_handler)

mysql.init_app(app)
app.config.from_object(__name__)
ck = Blueprint('ck_page', __name__, static_folder=chartkick.js(), static_url_path='/static')
app.register_blueprint(ck, url_prefix='/ck')
app.jinja_env.add_extension("chartkick.ext.charts")

UPLOAD_FOLDER = 'uploads/'
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

def allowed_file(filename):
	return '.' in filename and \
		filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS

oauth = OAuth(app)

from twitter import CONSUMER_KEY, CONSUMER_SECRET

twitter = oauth.remote_app(
	'twitter',
	consumer_key= CONSUMER_KEY,
	consumer_secret= CONSUMER_SECRET,
	base_url='https://api.twitter.com/1.1/',
	request_token_url='https://api.twitter.com/oauth/request_token',
	access_token_url='https://api.twitter.com/oauth/access_token',
	authorize_url='https://api.twitter.com/oauth/authorize',
)

@app.route('/uploads/<filename>')
def uploaded_file(filename):
	return send_from_directory(app.config['UPLOAD_FOLDER'], filename)

@twitter.tokengetter
def get_twitter_token():
	if 'twitter_oauth' in session:
		resp = session['twitter_oauth']
		return resp['oauth_token'], resp['oauth_token_secret']


@app.before_request
def before_request():
	g.user = None
	if 'twitter_oauth' in session:
		g.user = session['twitter_oauth']
		print g.user

def tup2float(tup):
	return float('.'.join(str(x) for x in tup))

def get_cursor():
	return mysql.connect().cursor()

oauth = OAuth(app)

IDOLONDEMAND_OCR_API = "http://api.idolondemand.com/1/api/sync/{}/v1"
apikey = "3687467a-ce51-4ced-8692-cebb5ce5ea0c"

def postrequests(function,data={},files={}):
	data["apikey"]=apikey
	callurl=IDOLONDEMAND_OCR_API.format(function)
	r=requests.post(callurl,data=data,files=files)
	return r.json()

@app.errorhandler(404)
def page_not_found(e):
	return render_template('404.djt'), 404

@app.route('/leaderboard', methods=['GET'])
def leaderboard():
	db = get_cursor()
	sql = 'select * from user_login join cuisine on cuisine.cuisine_id = user_login.cuisine_id order by points desc'
	db.execute(sql)
	values = db.fetchall()
	pprint(values)
	cuisines = []
	location = []
	for Object in values:
		cuisines.append(Object[16])
		location.append(Object[11])
	cuisinesCounter = dict(list(Counter(cuisines).iteritems()))
	locationCounter = dict(list(Counter(location).iteritems()))
	pprint(cuisinesCounter)
	pprint(locationCounter)
	cusinesList = {}
	locationList = {}
	for key, value in locationCounter.iteritems():
		cusinesList[str(key)] = value
	for key, value in cuisinesCounter.iteritems():
		locationList[str(key)] = value
	pprint(cusinesList)
	return render_template('leaderboard.djt', cusinesList=cusinesList, locationList=locationList, values=values)

@app.route('/')
def screen():
	return render_template('index.djt')

@app.route('/placeorder', methods=['GET', 'POST'])
def placeorder():
	if request.method == 'POST':
		return render_template('query.djt')


@app.route('/submitbill', methods = ['GET', 'POST'])
def submitbill():
	if request.method == 'POST':
		file = request.files['file']
		queryText = request.form['bill']
		if file and allowed_file(file.filename):
			filename = secure_filename(file.filename)
			file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
			filepath = 'uploads/'+filename
			result=postrequests('ocrdocument',data={'mode':'photo'},files={'file': open(filepath,'rb')})
			text = result['text_block'][0]['text']
			if queryText in text:
				mesg = "Yay ! You've made it for today."
				db = get_cursor()
				sql = 'insert into `bills` (`bill_no`,`res_id`,`order_id`,`cuisine_id`,`loc_id`) VALUES ("%s","%s","%s","%s","%s")'%(queryText,text,queryText,random.randint(1,23),random.randint(1,100))
				db.execute(sql)
				updatePoints = 'update user_login set points=points+10 where username = "%s"'%app.config['USERNAME']
				db.execute(updatePoints)
				db.execute("COMMIT")
			else:
				mesg = None
			return render_template('success.djt', mesg=mesg, text=text, filename=filename)
	return render_template('billupload.djt')

@app.route('/restaurant/<id>')
def restaurant(id=None):
	return render_template('restaurant.djt')

@app.route('/restaurantLogin', methods=['GET', 'POST'])
def restaurantLogin():
	if request.method == 'POST':
		db = get_cursor()
		res_id = request.form['res_id']
		password = request.form['password']
		print res_id, password
		sql = 'select * from restaurant where res_id LIKE "%s" and password LIKE MD5("%s")'%(str(res_id), str(password))
		db.execute(sql)
		result = db.fetchone()
		if not result:
			return redirect(url_for('screen'))
		session['logged_in'] = True
		app.config['USERNAME'] = res_id
		return render_template('dashboard.djt')
	return render_template('restaurantLogin.djt')

@app.route('/registerRestaurant', methods=['GET', 'POST'])
def registerRestaurant():
	if request.method == 'POST':
		db = get_cursor()
		noQry = 'select count(*) from restaurant'
		db.execute(noQry)
		count = db.fetchone()[0]
		print count
		res_id = int(count) + 1
		resname = request.form['resname']
		location = request.form['location']
		city = request.form['city']
		state = request.form['state']
		status = 0 # Closed by default
		rating = 0
		serv_type = request.form['serv_type']
		no_people_visited = 0
		no_people_liked = 0
		pure_veg = request.form['pure_veg']
		password = request.form['password']
		# res_id = int(count) + 1
		# resname = "Taj Krishna"
		# location = "Banjara Hilla"
		# city = "Hyderabad"
		# state = "Telangana"
		# status = 0 # Closed by default
		# rating = 0
		# serv_type = "Dining, Take Away"
		# no_people_visited = 0
		# no_people_liked = 0
		# pure_veg = 1
		# password = "root"
		# insertQuery = 'INSERT INTO `restaurant` (`res_id`, `res_name`, `location`, `city`, `state`, `status`, `rating`, `serv_type`, `no_people_visited`, `no_people_liked`, `pure_veg`, `password`) VALUES ("%s","%s","%s","%s","%s","%s","%s","%s","%s","%s")'
		Query1 = "INSERT INTO `restaurant`(`res_id`, `res_name`, `location`, `city`, `state`, `status`, `rating`, `serv_type`, `no_people_visited`, `no_people_liked`, `pure_veg`, `password`) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', MD5('%s'))"%(str(res_id),resname,location,city,state,str(status),str(rating),serv_type,str(no_people_visited), str(no_people_liked), str(pure_veg), password)
		Query = "INSERT INTO `restaurant`(`res_id`, `res_name`, `location`, `city`, `state`, `status`, `rating`, `serv_type`, `no_people_visited`, `no_people_liked`, `pure_veg`, `password`) VALUES ('1', 'test', 'no', 'no2', 'no3', '1', '0', 'dine-in', '0', '0', '1', MD5('test'))"
		db.execute(Query1)
		db.execute("COMMIT")
		print "restaurant entry success !"
		return render_template('restaurantSuccess.djt', password=password, res_id=res_id)
	return render_template('registerRestaurant.djt')


@app.route('/dashboard')
def dashboard():
	db = get_cursor()
	sql = 'select * from user_login where username="%s"'%app.config['USERNAME']
	db.execute(sql)
	names = db.fetchone()
	imageUrl = hashlib.md5(names[2]).hexdigest()
	return render_template('dashboard.djt', names=names, imageUrl=imageUrl)

@app.route('/signup', methods=['GET','POST'])
def signup():
	if request.method == 'POST':
		db = get_cursor()
		username = request.form['username']
		password = request.form['password']
		confpass = request.form['confirmpassword']
		email = request.form['email']
		userType = 1
		firstName = request.form['fname']
		lastName = request.form['lname']
		height = request.form['height']
		weight = request.form['weight']
		phone = request.form['phone']
		addr = request.form['address']
		favCuisine = request.form['cuisine']
		locationId = request.form['location']
		likes = 0
		points = 0
		wallet = 0
		if password == confpass:
			fullname = firstName+' '+lastName
			bmi = float(weight)/(float(height)*float(height))
			sql = 'INSERT INTO `user_login`(`username`, `password`, `email`, `type`, `full_name`, `BMI`, `height`, `weight`, `phone`, `address`, `cuisine_id`, `location`, `likes`, `points`, `wallet`) VALUES ("%s", MD5("%s"), "%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s")'
			db.execute(sql%(username, password, email, userType, fullname, bmi, height, weight, phone, addr, favCuisine, locationId, likes, points, wallet))
			db.execute("COMMIT")
			print "Success"
			return redirect(url_for('login'))
		print "Failed"
		return redirect(url_for('login'))
	db = get_cursor()
	sql = 'select * from cuisine'
	db.execute(sql)
	cuisines = db.fetchall()
	cuisinesList = cuisines
	db.execute("Commit")
	return render_template('signup.djt', cuisinesList=cuisinesList)

@app.route('/login', methods= ['GET', 'POST'])
def login():
	global store
	error = None
	db=get_cursor()
	session['temp']=0
	if request.method == 'POST':
		username = str(request.form['username'])
		password = str(request.form['password'])
		sql = 'select * from user_login where username="%s" and password=MD5("%s")'%(username, password)
		db.execute(sql)
		result = db.fetchone()
		if not result:
			error = "Invalid username and password"
		else:
			session['logged_in'] = True
			app.config['USERNAME'] = username
			return redirect(url_for('dashboard'))
	return render_template('login.djt')

@app.teardown_appcontext
def close_db(self):
	"""Closes the database again at the end of the request."""
	get_cursor().close()

@app.route('/logout')
def logout():
	if g.user is not None:
		twitterlogout()
	if session['logged_in'] != None:
		if session['logged_in']==True:
			session.pop('logged_in', None)
			session.pop('temp',0)
		else:
			flash('Welcome Back!')
	return redirect(url_for('login'))#show_entries.html

@app.route('/twitter')
def index():
	tweets = None
	if g.user is not None:
		resp = twitter.request('statuses/home_timeline.json')
		if resp.status == 200:
			tweets = resp.data
			pprint(tweets)
		else:
			flash('Unable to load tweets from Twitter.')
	db = get_cursor()
	sql = 'select * from user_login where username="%s"'%app.config['USERNAME']
	db.execute(sql)
	names = db.fetchone()
	imageUrl = hashlib.md5(names[2]).hexdigest()
	return render_template('dashboard.djt', tweets=tweets, names=names, imageUrl=imageUrl)

@app.route('/tweet', methods=['POST'])
def tweet():
	if g.user is None:
		return redirect(url_for('twitterlogin', next=request.url))
	status = request.form['tweet']
	if not status:
		return redirect(url_for('index'))
	resp = twitter.post('statuses/update.json', data={
		'status': status
	})
	if resp.status == 403:
		flash('Your tweet was too long.')
	elif resp.status == 401:
		flash('Authorization error with Twitter.')
	else:
		flash('Successfully tweeted your tweet (ID: #%s)' % resp.data['id'])
	index()
	return redirect(url_for('twitter'))


@app.route('/twitterlogin')
def twitterlogin():
	callback_url = url_for('oauthorized', next=request.args.get('next'))
	return twitter.authorize(callback=callback_url or request.referrer or None)


@app.route('/twitterlogout')
def twitterlogout():
	session.pop('twitter_oauth', None)
	return redirect(url_for('index'))


@app.route('/oauthorized')
def oauthorized():
	resp = twitter.authorized_response()
	if resp is None:
		flash('You denied the request to sign in.')
	else:
		session['twitter_oauth'] = resp
	return redirect(url_for('index'))

if __name__ == '__main__':
	app.debug = True
	app.secret_key=os.urandom(24)
	# app.permanent_session_lifetime = datetime.timedelta(seconds=200)
	app.run(host='0.0.0.0', port=8080)
