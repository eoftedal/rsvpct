
#On heroku we read the variable from environments (different from this one), but when running locally we use this one:
Rsvpct::Application.config.secret_token = ENV['SECRET_TOKEN'] || '8d9b940825434350ebb908f33eea79ae943f1671282d1e1df81a537e78df9627cf5ea8e97eff1c38b101848b90c352450a23a0c1c48b70e21cdec889ad52f40f'
