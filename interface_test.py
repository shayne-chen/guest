import requests

def test_get_event_list(event_id, name):
	url = "http://127.0.0.1:8000/api/get_event_list/"
	#params = 'event_id=%s&name=%s'%(event_id, name)
	#interface_url = url + "/?" + params
	params = {"event_id":event_id, "name":name}
	result = requests.get(url, params=params)
	print (result.json())


def test_add_event():
	url = "http://127.0.0.1:8000/api/add_event/"
	params = {"event_id":"2", "name":"iPhone 18发布会", "limit":"100", "address":"Beijing", "start_time":"2018-09-12 12:00:00"}
	result = requests.post(url, data=params)
	print (result.json())


def test_get_guest_list(event_id, phone):
	url = "http://127.0.0.1:8000/api/get_guest_list/"
	#params = "event_id=%s&phone=%s"%(event_id, phone)
	#interface_url = url + "/?" + params
	params = {"event_id":event_id, "phone":phone}
	result = requests.get(url, params=params)
	print (result.json())


def test_add_guest():
	url = "http://127.0.0.1:8000/api/add_guest/"
	params = {"event_id":"2", "realname":"chen_shaw", "phone":"18310610898", "email":"chen_xiao@163.com"}
	result = requests.post(url, data=params)
	print (result.json())



def test_user_sign(event_id, phone):
	url  = "http://127.0.0.1:8000/api/user_sign/"
	params = {"event_id":event_id, "phone":phone}
	result = requests.post(url, data=params)
	print (result.json())



def test_change_guest(event_id, realname, phone, email):
	url = "http://127.0.0.1:8000/api/change_guest/"
	params = {"event_id":event_id, "realname":realname, "phone":phone, "email":email}
	result = requests.post(url, data=params)
	print (result.json())



def test_delete_guest(event_id, realname, phone):
	url = "http://127.0.0.1:8000/api/delete_guest/"
	params = {"event_id":event_id, "realname":realname, "phone":phone}
	result = requests.post(url, data=params)
	print (result.json())


def test_detele_event(event_id, name):
	url = "http://127.0.0.1/8000/api/delete_event/"
	params = {"event_id":event_id, "name":name}
	result = requests.post(url, data=params)
	print(result.json())


if __name__ == '__main__':
	#test_get_event_list("", "")
	#test_get_guest_list("1", "")
	#test_add_event()
	test_add_guest()
	#test_user_sign("1", "18310610895")
	#test_change_guest(1,"shawn","18310610895","shawn@163.com")
	#test_delete_guest(1, "shawn", "18310610895")
