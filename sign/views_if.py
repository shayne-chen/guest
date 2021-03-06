from django.http import JsonResponse
from sign.models import Event, Guest
from django.core.exceptions import ValidationError, ObjectDoesNotExist
from django.db.utils import IntegrityError
import time, datetime, pytz


#添加发布会接口
def add_event(request):
	event_id = request.POST.get('event_id', '')
	name = request.POST.get('name', '')
	limit = request.POST.get('limit', '')
	status = request.POST.get('status', '')
	address = request.POST.get('address', '')
	start_time = request.POST.get('start_time', '')

	if event_id =='' or name == '' or limit == '' or address == '' or start_time == '':
		return JsonResponse({"status":10021, "message":"parameter error"})

	result = Event.objects.filter(id=event_id)
	if result:
		return JsonResponse({"status":10022, "message":"event id already exists"})

	result = Event.objects.filter(name=name)
	if result:
		return JsonResponse({"status":10023, "message":"event name already exists"})

	if status == '':
		status = 1

	try:
		Event.objects.create(id=event_id, name=name, limit=limit, address=address, status=int(status), start_time=start_time)
	except ValidationError as e:
		error = "start_time format error. It must be in YYYY-MM-DD HH:MM:SS format."
		return JsonResponse({"status":10024, "message":error})
	
	return JsonResponse({"status":200, "message":"add event success"})


#发布会查询
def get_event_list(request):
	event_id = request.GET.get("event_id", "")
	name = request.GET.get("name", "")

	if event_id == '' and name == '':
		#return JsonResponse({"status":10021, "message":"parameter error"})
		result = Event.objects.all()
		datas = []
		for r in result:
			event = {}
			event['event_id'] = r.id
			event['name'] = r.name
			event['limit'] = r.limit
			event['status'] = r.status
			event['address'] = r.address
			event['start_time'] = r.start_time
			datas.append(event)
		return JsonResponse({"status":10021, "message":"success", "data":datas})

	if event_id != '':
		event = {}
		try:
			result = Event.objects.get(id=event_id)
		except ObjectDoesNotExist:
			return JsonResponse({"status":10022, "message":"query result is empty"})
		else:
			event['name'] = result.name
			event['limit'] = result.limit
			event['status'] = result.status
			event['address'] = result.address
			event['start_time'] = result.start_time
			return JsonResponse({"status":200, "message":"success", "data":event})

	if name != '':
		datas = []
		results = Event.objects.filter(name__contains=name)
		if results:
			for r in results:
				event = {}
				event['name'] = r.name
				event['limit'] = r.limit
				event['status'] = r.status
				event['address'] = r.address
				event['start_time'] = r.start_time
				datas.append(event)
			return JsonResponse({"status":200, "message":"success", "data":datas})
		else:
			return JsonResponse({"status":10022, "message":"query result is empty"})



#删除发布会
def delete_event(request):
	event_id = request.POST.get("event_id", "")
	name = request.POST.get("name", "")

	if event_id == "" or name == "":
		return JsonResponse({"status":10021, "message":"parameter error"})

	try:
		result = Event.objects.get(id=event_id, name=name)
	except ObjectDoesNotExist:
		return JsonResponse({"status":10022, "message":"event is not exists"})
	else:
		result.delete()
		return JsonResponse({"status":10023, "message":"delete event success"})



#添加嘉宾接口
def add_guest(request):
	event_id = request.POST.get('event_id', '')
	realname = request.POST.get('realname', '')
	phone = request.POST.get('phone', '')
	email = request.POST.get('email', '')

	if event_id == '' or realname == '' or phone == '':
		return JsonResponse({"status":10021, "message":"parameter error"})

	result = Event.objects.filter(id=event_id)
	if not result:
		return	JsonResponse({"status":10022, "message":"event id is null"})

	result = Event.objects.get(id=event_id).status
	if not result:
		return JsonResponse({"status":10023, "message":"event status is not available"})

	event_limit = Event.objects.get(id=event_id).limit                 #发布会限制人数
	guest_limit = Guest.objects.filter(event_id=event_id)              #发布会已添加的嘉宾数

	if len(guest_limit) >= event_limit:
		return	JsonResponse({"status":10024, "message":"event number is full"})

	event_time = Event.objects.get(id=event_id).start_time
	now = datetime.datetime.now()
	now_time = now.replace(tzinfo=pytz.timezone('UTC'))

	if event_time < now_time:
	 	return JsonResponse({"status":10025, "message":"event has started"})
	try:
		Guest.objects.create(realname=realname, phone=int(phone), email=email, sign=0, event_id=int(event_id))
	except IntegrityError:
		return JsonResponse({"status":10026, "message":"the event guest phone number repeat"})

	return JsonResponse({"status":200, "message":"add guest success"})



#嘉宾查询
def get_guest_list(request):
	event_id = request.GET.get("event_id", "")
	phone = request.GET.get("phone", "")

	if event_id == "":
		return JsonResponse({"status":10021, "message":"event_id can not be empty"})

	if event_id != "" and phone == "":
		datas = []
		results = Guest.objects.filter(event_id=event_id)
		if results:
			for r in results:
				guest = {}
				guest["realname"] = r.realname
				guest["phone"] = r.phone
				guest["email"] = r.email
				guest["sign"] = r.sign
				datas.append(guest)
			return JsonResponse({"status":200, "message":"success", "data":datas})
		else:
			return JsonResponse({"status":10022, "message":"query result is empty"})

	if event_id != "" and phone != "":
		guest = {}
		try:
			result = Guest.objects.get(phone=phone, event_id=event_id)
		except ObjectDoesNotExist:
			return JsonResponse({"status":10022, "message":"query result is empty"})
		else:
			guest["realname"] = result.realname
			guest["phone"] = result.phone
			guest["email"] = result.email
			guest["sign"] = result.sign
			return JsonResponse({"status":200, "message":"success", "data":guest})


#修改嘉賓信息
def change_guest(request):
	event_id = request.POST.get("event_id", "")
	realname = request.POST.get("realname", "")
	phone = request.POST.get("phone", "")
	email = request.POST.get("email", "")

	if event_id == "" or realname == "" or phone == "" or email == "":
		return JsonResponse({"status":10021, "message":"parameter error"})
	
	result = Event.objects.filter(id=event_id)
	if not result:
		return JsonResponse({"status":10022, "message":"event_id null"})

	try:
		result = Guest.objects.get(phone=phone, event_id=event_id)
	except ObjectDoesNotExist:
		return JsonResponse({"status":10023, "message":"guest is not exists"})
	else:
		Guest.objects.filter(event_id=event_id, phone=phone).update(realname=realname, phone=phone, email=email, sign="1")
		return JsonResponse({"status":10024, "message":"change guest info success"})



#刪除嘉賓
def delete_guest(request):
	event_id = request.POST.get("event_id", "")
	phone = request.POST.get("phone", "")
	realname = request.POST.get("realname", "")

	if event_id == "" or phone == "" or realname == "":
		return JsonResponse({"status":10021, "message":"parameter error"})

	result = Event.objects.get(id=event_id)
	if not result:
		return JsonResponse({"status":10022, "message":"event_id null"})

	try:
		result = Guest.objects.get(event_id=event_id, phone=phone, realname=realname)
	except ObjectDoesNotExist:
		return JsonResponse({"status":10023, "message":"guest not exists"})
	else:
		result.delete()
		return JsonResponse({"status":10024, "message":"delete success"})




#嘉宾签到接口
def user_sign(request):
	event_id = request.POST.get("event_id", "")
	phone = request.POST.get("phone", "")

	if event_id == "" or phone == "":
		return JsonResponse({"status":10021, "message":"parameter error"})

	result = Event.objects.filter(id=event_id)
	if not result:
		return JsonResponse({"status":10022, "message":"event id null"})

	result = Event.objects.get(id=event_id).status
	if not result:
		return JsonResponse({"status":10023, "message":"event status is not available"})

	event_time = Event.objects.get(id=event_id).start_time
	now = datetime.datetime.now()
	now_time = now.replace(tzinfo=pytz.timezone('UTC'))

	if event_time < now_time:
	 	return JsonResponse({"status":10024, "message":"event has started"})

	result = Guest.objects.filter(phone=phone)
	if not result:
		return JsonResponse({"status":10025, "message":"user phone null"})

	result = Guest.objects.get(event_id=event_id, phone=phone)
	if not result:
		return JsonResponse({"status":10026, "message":"user did not participate in the conference"})
	
	if result.sign:
		return JsonResponse({"status":10027, "message":"user has sign in"})
	else:
		Guest.objects.filter(event_id=event_id, phone=phone).update(sign='1')
		return JsonResponse({"status":200, "message":"sign success"})


def jenkins_test(request):
	print ("docker jenkins test 1.0")
	return 0
